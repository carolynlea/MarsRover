//
//  PhotosCollectionViewController.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController
{
    private let client = MarsRoverClient()
    private let cache = Cache<Key, Value>()
    private let photoFetchQueue = OperationQueue()
    private let imageFilteringQueue = OperationQueue()
    private var operations = [Int : Operation]()
    let solLabel = UILabel()
    
    private var roverInfo: MarsRover?
    {
        didSet
        {
            solDescription = roverInfo?.solDescriptions[10]
        }
    }
    private var solDescription: SolDescription?
    {
        didSet
        {
            if let rover = roverInfo,
                let sol = solDescription?.sol
            {
                photoReferences = []
                client.fetchPhotos(from: rover, onSol: sol) { (photoRefs, error) in
                    
                    if let e = error { NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(e)"); return }
                    
                    self.photoReferences = photoRefs ?? []
                    DispatchQueue.main.async { self.updateViews() }
                }
            }
        }
    }
    private var photoReferences = [MarsPhoto]()
    {
        didSet
        {
            cache.clear()
            DispatchQueue.main.async { self.collectionView?.reloadData() }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        client.fetchMarsRover(named: "curiosity") { (rover, error) in
            if let error = error {
                NSLog("Error fetching info for curiosity: \(error)")
                return
            }
            
            self.roverInfo = rover
        }
        
        configureTitleView()
        updateViews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowDetail"
        {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let detailVC = segue.destination as! PhotoDetailViewController
            detailVC.photo = photoReferences[indexPath.item]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photoReferences.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell ?? ImageCollectionViewCell()
    
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if photoReferences.count > 0
        {
            let photoRef = photoReferences[indexPath.item]
            operations[photoRef.identifier]?.cancel()
        }
        else
        {
            for (_, operation) in operations {
                operation.cancel()
            }
        }
    }
    
    private func configureTitleView() {
        
        let font = UIFont.systemFont(ofSize: 30)
        let attrs = [NSAttributedString.Key.font: font]
        
        let prevButton = UIButton(type: .system)
        let prevTitle = NSAttributedString(string: "<", attributes: attrs)
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)
        
        let nextButton = UIButton(type: .system)
        let nextTitle = NSAttributedString(string: ">", attributes: attrs)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        navigationItem.titleView = stackView
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        solLabel.text = "Sol \(solDescription?.sol ?? 0)"
    }
    
    private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoReference = photoReferences[indexPath.item]
        
        // Check for image in cache
        if let cachedImage = cache.value(for: photoReference.id){
            cell.imageView.image = cachedImage
            return
        }
        
        // Start an operation to fetch image data
        let fetchOp = FetchPhotoOperation(photoReference: photoReference)
        let filterOp = FilterImageOperation(fetchOperation: fetchOp)
        filterOp.completionBlock = {
            NSLog("filter op finished")
        }
        let cacheOp = BlockOperation {
            if let image = filterOp.image{
                self.cache.cache(value: image, for: photoReference.id)
            }
        }
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: photoReference.identifier) }
            
            if let currentIndexPath = self.collectionView?.indexPath(for: cell),
                currentIndexPath != indexPath {
                return // Cell has been reused
            }
            
            if let image = filterOp.image {
                cell.imageView?.image = image
            }
        }
        
        filterOp.addDependency(fetchOp)
        cacheOp.addDependency(filterOp)
        completionOp.addDependency(filterOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        imageFilteringQueue.addOperation(filterOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[photoReference.identifier] = fetchOp
    }

    @IBAction func goToPreviousSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescriptions else { return }
        guard let index = solDescriptions.index(of: solDescription) else { return }
        guard index > 0 else { return }
        self.solDescription = solDescriptions[index-1]
    }
    
    @IBAction func goToNextSol(_ sender: Any?) {
        guard let solDescription = solDescription else { return }
        guard let solDescriptions = roverInfo?.solDescriptions else { return }
        guard let index = solDescriptions.index(of: solDescription) else { return }
        guard index < solDescriptions.count - 1 else { return }
        self.solDescription = solDescriptions[index+1]
    }
    
}
