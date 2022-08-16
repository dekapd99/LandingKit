//
//  LandingViewController.swift
//  
//
//  Created by Deka Primatio on 15/08/22.
//

import UIKit

// Routes commands to the model and view parts
class LandingViewController: UIViewController {
    
    // Properties / Dependencies for Init
    private let slides: [Slide]
    private let tintColor: UIColor
    
    // Internal Init, we dont want to expose our Controller, let Client Communicate via LandingKit.swift
    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)
    }
    
    // Default Required Init by Xcode
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
