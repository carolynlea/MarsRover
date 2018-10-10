//
//  Image+Filtering.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

extension UIImage
{
    func filtered() -> UIImage
    {
        let context = CIContext(options: nil)
        let input = CIImage(image: self)
        
        let sharpenFilter = CIFilter(name: "CISharpenLuminance")!
        sharpenFilter.setValue(0.5, forKey: kCIInputSharpnessKey)
        let contrastFilter = CIFilter(name: "CIColorControls")!
        contrastFilter.setValue(1.5, forKey: kCIInputContrastKey)
        
        sharpenFilter.setValue(input, forKey: kCIInputImageKey)
        contrastFilter.setValue(sharpenFilter.outputImage, forKey: kCIInputImageKey)
        
        let output = contrastFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)
        return UIImage(cgImage: cgImage!)
    }
}
