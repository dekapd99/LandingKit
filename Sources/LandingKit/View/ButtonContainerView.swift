//
//  ButtonContainerView.swift
//  
//
//  Created by Deka Primatio on 17/08/22.
//

import UIKit
import SnapKit

class ButtonContainerView: UIView {
    
    // Exposes Closure Tapped Button for Controller (Parent)
    var nextButtonDidTap: (() -> Void)?
    var getStartedButtonDidTap: (() -> Void)?
    
    // "Next" & "Get Started" Button Properties and StackView for Button Position Layout
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(viewTintColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        button.backgroundColor = viewTintColor
        button.layer.cornerRadius = 12
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.layer.shadowRadius = 8
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Instance for Encapsulation Stacks nextButton & getStartedButton above
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nextButton, getStartedButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    private let viewTintColor: UIColor // To Connect with TintColor Depdency in Controller
    
    // Internal Init for ButtonContainerView
    init(tintColor: UIColor) {
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        buttonLayout()
    }
    
    // Default Required Init by Xcode
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Callback Function for ButtonContainerView with Auto Layout
    private func buttonLayout() {
        addSubview(stackView) // Add Subview for stackViews above
        
        // Pin all the edges to ButtonContainerView
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        
        // Making Next Button Half Shorter the getStartedButton
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
        }
    }
    
    // Objective-C Function: #Selector addTarget for Closure Buttons
    @objc private func nextButtonTapped() {
        nextButtonDidTap?()
    }
    @objc private func getStartedButtonTapped() {
        getStartedButtonDidTap?()
    }
}
