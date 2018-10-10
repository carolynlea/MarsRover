//
//  FetchPhotoOperation.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation
{
    
    init(photoReference: MarsPhoto, session: URLSession = URLSession.shared)
    {
        self.photoReference = photoReference
        self.session = session
        super.init()
    }
    
    override func start()
    {
        state = .isExecuting
        let url = photoReference.imageURL.usingHTTPS!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            if let error = error {
                NSLog("Error fetching data for \(self.photoReference): \(error)")
                return
            }
            
            self.imageData = data
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel()
    {
        dataTask?.cancel()
        super.cancel()
    }
    
    // MARK: Properties
    
    let photoReference: MarsPhoto
    
    private let session: URLSession
    
    private(set) var imageData: Data?
    
    private var dataTask: URLSessionDataTask?
}
