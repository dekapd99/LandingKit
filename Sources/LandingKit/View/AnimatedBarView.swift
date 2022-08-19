//
//  AnimatedBarView.swift
//  
//
//  Created by Deka Primatio on 18/08/22.
//

import UIKit
import Combine

class AnimatedBarView: UIView {
    
    enum State {
        case clear
        case animating
        case filled
    }
    
    // Background & Foreground Bar View Properties
    private lazy var backgroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor.withAlphaComponent(0.2)
        view.clipsToBounds = true
        return view
    }()
    private lazy var foregroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor
        view.alpha = 0.0 // Making it Transparent at the Start of "Progress" Animation
        return view
    }()
    
    @Published private var state: State = .clear // Monitoring Current State of "Progress" Animation
    private var subscribers = Set<AnyCancellable>() // Combine Subscribers
    private var animator: UIViewPropertyAnimator // Swift Object for Managing the Animation
    
    // To Connect with Slide & viewTintColor Depedencies in Controller
    private let barColor: UIColor
    
    init(barColor: UIColor) {
        self.barColor = barColor
        super.init(frame: .zero)
        setupAnimator()
        animatedLayout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimator() {
        // Duration = duration of progress to be complete, Curve = the animation effect
        animator = UIViewPropertyAnimator(
            duration: 3.0,
            curve: .easeInOut, animations: {
                self.foregroundBarView.transform = .identity
        })
    }
    
    // Function for Animation Behaviour
    private func observe() {
        $state.sink { [unowned self] state in
            switch state {
            case .clear:
                setupAnimator() // Re-initialize the previous animation when Left-Side Touches
                foregroundBarView.alpha = 0.0
                animator.stopAnimation(false)
            case .animating:
                foregroundBarView.transform = .init(scaleX: 0, y: 1.0) // 0% Progression
                foregroundBarView.transform = .init(translationX: -frame.size.width, y: 0) // Start from the Left
                foregroundBarView.alpha = 1.0 // Full Color of Progressing
                animator.startAnimation()
            case .filled:
                animator.stopAnimation(true)
                foregroundBarView.transform = .identity
            }
        }.store(in: &subscribers)
    }
    
    // Callback Function for AnimatedBarView with Auto Layout
    private func animatedLayout() {
        // Making foregroundBarView as Subview of backgroundBarView for Fade In & Fade Out Animation
        addSubview(backgroundBarView)
        backgroundBarView.addSubview(foregroundBarView)
        
        backgroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        foregroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundBarView)
        }
    }
    
    func startAnimating() {
        state = .animating
    }
    
    func reset() {
        state = .clear
    }
    
    func complete() {
        state = .filled
    }
}
