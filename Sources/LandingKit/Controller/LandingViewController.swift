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
    
    // Instance for View, lazy var to be able to pass properties above
    private lazy var transitionView: TransitionView = {
        let view = TransitionView(slides: slides, tintColor: tintColor)
        return view
    }()
    private lazy var buttonContainerView: ButtonContainerView = {
        let view = ButtonContainerView(tintColor: tintColor)
        view.nextButtonDidTap = {
            print("Next Button Tapped")
        }
        view.getStartedButtonDidTap = {
            print("Get Started Button Tapped")
        }
        return view
    }()
    
    // Instance for Encapsulation Stacks transitionView & buttonContainerView above
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transitionView, buttonContainerView])
        view.axis = .vertical
        return view
    }()
    
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
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    // Callback Function for LandingViewController with Auto Layout
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView) // Add Subview for stackViews above
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view) // Pin all the edges to LandingViewController
        }
        
        buttonContainerView.snp.makeConstraints { make in
            make.height.equalTo(120) // Taking 120 pixels height for buttonContainerView
        }
    }
}
