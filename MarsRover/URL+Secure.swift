//
//  URL+Secure.swift
//  MarsRover
//
//  Created by Carolyn Lea on 10/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

extension URL
{
    var usingHTTPS: URL?
    {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        return components.url
    }
}
