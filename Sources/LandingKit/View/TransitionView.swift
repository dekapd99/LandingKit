//
//  TransitionView.swift
//  
//
//  Created by Deka Primatio on 17/08/22.
//

import UIKit

class TransitionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        transitionLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Fungsi setup color & layout
    private func transitionLayout() {
        backgroundColor = .blue
    }
    
}
