//
//  PhotoDetailViewController.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController
{

    @IBOutlet weak var imageView: UIImageView!
    
    var photo: MarsPhoto?
    {
        didSet
        {
            updateViews()
        }
    }
    
    private func updateViews()
    {
        guard let photo = photo, isViewLoaded else {return}
        
        do
        {
            let data = try Data(contentsOf: photo.imageURL.usingHTTPS!)
            imageView.image = UIImage(data: data)?.filtered()
        }
        catch
        {
            NSLog("error getting image: \(error)")
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }
    

    

}
