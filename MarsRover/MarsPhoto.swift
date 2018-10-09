//
//  MarsPhoto.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

struct MarsPhotoReference: Codable
{
    let id: Int
    let sol: Int
    let camera: Camera
    let earthDate: Date
    
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case sol
        case camera
        case earthDate
        case imageURL = "imgSrc"
    }
    
    static let dateFormatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static var jsonDecoder: JSONDecoder
    {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}