//
//  ViewController.swift
//  TestConcurrency
//
//  Created by Тагир Файрушин on 21.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var customView: CustomView {
        self.view as! CustomView
    }
    
    var collectionViewDataSource: CollectionViewDataSource?
    var collectionViewDelegate: CollectionViewDelegate?
    var modelData = ModelData()
    var calculator = CalculateFormul()
    
    private lazy var actionSegmentControll: UIAction = {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.segmentChanged(segment: customView.segmentControll)
        }
    }()
    
    private lazy var actionCalculation: UIAction = {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.calculationFactorial(n: 20)
            }
        }
    }()
    
    override func loadView() {
        view = CustomView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewDataSource = CollectionViewDataSource(collectionView: customView.collectionView, photos: modelData.obtainPhoto())
        self.collectionViewDelegate = CollectionViewDelegate()
        customView.collectionView.delegate = collectionViewDelegate
        setupSegmentControll()
        setupLabel()
        setupButton()
    }
    
    private func setupSegmentControll() {
        let titles = modelData.obtainTitleSegment()
        for (index, title) in titles.enumerated() {
            customView.segmentControll.insertSegment(withTitle: title, at: index, animated: false)
        }
        customView.segmentControll.addAction(actionSegmentControll, for: .valueChanged)
    }
    
    private func updateProgressView(currentTask: Int) {
        let progress = Float(currentTask) / Float(20)
        DispatchQueue.main.async {
            self.customView.progressView.setProgress(progress, animated: true)
        }
    }
    
    private func calculationFactorial(n: Int) async {
        var currentTask = 1
       
        currentTask += 1
        for i in 1...n {
            let result = calculator.factorial(i)
            DispatchQueue.main.async {
                self.customView.label.text = "Факториал \(i) = \(result)"
            }
            currentTask += 1
            updateProgressView(currentTask: currentTask)
            await Task.sleep(100000000)
        }
    }
    
    private func setupLabel() {
        customView.label.text = modelData.obtainTitleLabel()
    }
    
    private func setupButton() {
        let titles = modelData.obtainTitleButton()
        customView.buttonCalculation.configuration?.title = titles[0]
        customView.buttonCalculation.addAction(actionCalculation, for: .touchUpInside)
        customView.buttonCancelCalculation.configuration?.title = titles[1]
    }
    
    private func segmentDiactivate() {
        customView.segmentControll.isEnabled = false
    }
    
    private func segmentActivate() {
        customView.segmentControll.isEnabled = true
    }
    
    private func segmentChanged(segment: UISegmentedControl) {
        segmentDiactivate()
        switch segment.selectedSegmentIndex {
        case 0: filteringPhotoConcurrent()
        case 1: filteringPhotoSerial()
        default: return
        }
    }
    
    private func filteringPhotoConcurrent() {
        let dispatchGroup = DispatchGroup()
        let concurrentDispatch = DispatchQueue(label: "com.example", attributes: .concurrent)
        guard let dataSource = collectionViewDataSource else { return }
        
        for index in 0..<dataSource.photos.count {
            concurrentDispatch.async {
                dispatchGroup.enter()
                let oldPhoto = dataSource.photos[index]
                let filteredPhoto = oldPhoto.addFilter(filter: FilterType.allCases.randomElement()!)
                
                DispatchQueue.main.async {
                    dataSource.photos[index] = filteredPhoto
                    dataSource.replaceItem(newItem: filteredPhoto, oldItem: oldPhoto, animated: true)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.segmentActivate()
        }
    }
    
    private func filteringPhotoSerial() {
        guard let dataSource = collectionViewDataSource else { return }
        
        let serialOperationQueue = OperationQueue()
        serialOperationQueue.maxConcurrentOperationCount = 1
        
        for index in 0..<dataSource.photos.count {
            serialOperationQueue.addOperation {
                let oldPhoto = dataSource.photos[index]
                let filteredPhoto = oldPhoto.addFilter(filter: FilterType.allCases.randomElement()!)
                
                DispatchQueue.main.async {
                    dataSource.photos[index] = filteredPhoto
                    dataSource.replaceItem(newItem: filteredPhoto, oldItem: oldPhoto, animated: true)
                }
                
                sleep(1)
            }
        }
        serialOperationQueue.addOperation {
            DispatchQueue.main.async {
                self.segmentActivate()
            }
        }
    }
}

extension UIImage {
    func addFilter(filter : FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        
        let ciOutput = filter?.outputImage
        let ciContext = CIContext() // рендиринг
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!) // конвертирует CIImage в CGImage
        
        return UIImage(cgImage: cgImage!)
    }
}
