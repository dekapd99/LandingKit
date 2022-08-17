//
//  ButtonContainerView.swift
//  
//
//  Created by Deka Primatio on 17/08/22.
//

import UIKit
import SnapKit

class ButtonContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonLayout() {
        backgroundColor = .systemPink
    }
}
