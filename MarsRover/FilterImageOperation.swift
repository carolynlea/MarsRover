//
//  FilterImageOperation.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation
import UIKit

class FilterImageOperation: Operation
{
    let fetchOperation: FetchPhotoOperation
    private(set) var image: UIImage?
    
    override func main()
    {
        if let data = fetchOperation.imageData,
            let image = UIImage(data: data)
        {
            self.image = image//.filtered()
        }
    }
    
    init(fetchOperation: FetchPhotoOperation)
    {
        self.fetchOperation = fetchOperation
    }
    
    
}
