//
//  Slide.swift
//  
//
//  Created by Deka Primatio on 15/08/22.
//

import UIKit

// Declaration of data & data type for Manages Data & Business Logic
public struct Slide {
    public let image: UIImage
    public let title: String
    
    // Initialize this when Slide Use
    public init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
}
