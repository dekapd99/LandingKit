//
//  TransitionView.swift
//  
//
//  Created by Deka Primatio on 17/08/22.
//

import UIKit

class TransitionView: UIView {
    
    private var timer: DispatchSourceTimer?
    
    // Images View Properties
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    // Array for Bar Animations Depends on How Many Images Added inside the Assets
    private lazy var barViews: [AnimatedBarView] = {
        var views: [AnimatedBarView] = []
        slides.forEach { _ in
            views.append(AnimatedBarView(barColor: viewTintColor))
        }
        return views
    }()
    
    /**
     * Instance for Encapsulation Stacks barView Images from Client
     * Whatever the Client passes via this light object we are going to generate
     * Number of barViews as needed for the screen it self, then distribute the bar size equally
     */
    private lazy var barStackView: UIStackView = {
        let stackView = UIStackView()
        barViews.forEach { barView in
            stackView.addArrangedSubview(barView)
        }
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // Title View Properties
    private lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    // Instance for Encapsulation Stacks imageView & titleView above
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleView])
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    // To Connect with Slide & viewTintColor Depedencies in Controller
    private let slides: [Slide]
    private let viewTintColor: UIColor
    
    private var index: Int = -1 // Index Pointer to keep the Array of Slides
    
    // Read Only Var for Index Calls in Controller
    var slideIndex: Int {
        return index
    }
    
    // Internal Init for TransitionView
    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        transitionLayout()
    }
    
    // Default Required Init Generated by Xcode
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Function Timer for Start & Stop Transitioning
    func start() {
        buildTimerIfNeeded()
        timer?.resume() // Start the Timer
    }
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    // Function Build The Timer, when it is Nil
    private func buildTimerIfNeeded() {
        guard timer == nil else { return }
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(3), leeway: .seconds(1))
        timer?.setEventHandler(handler: { [weak self] in
            // Self Disclosure in Main Thread to Avoid Memory Leak
            DispatchQueue.main.async {
                self?.showNext()
            }
        })
    }
    
    // Function Each Time the Timer Show the Next Event (Image)
    private func showNext() {
        let nextImage: UIImage
        let nextTitle: String
        let nextBarView: AnimatedBarView
        
        // if index is last, show first array of slides
        // else show next index
        
        // let say we are in the last elements which is index 4, if 4 + 1 = 5
        // then change 5 into 0, because there is no index 5, we want to go back to first index
        
        if slides.indices.contains(index + 1) {
            nextImage = slides[index + 1].image
            nextTitle = slides[index + 1].title
            nextBarView = barViews[index + 1]
            index += 1
        } else {
            barViews.forEach({ $0.reset() })
            // we are on the last index, we want to show the first
            nextImage = slides[0].image
            nextTitle = slides[0].title
            nextBarView = barViews[0]
            index = 0
        }
        // Animation Transition Image, Fade in / Fade Out
        UIView.transition(
            with: imageView,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                self.imageView.image = nextImage
            }, completion: nil)
        
        titleView.setTitle(text: nextTitle)
        nextBarView.startAnimating()
    }
    
    // Callback Function for TransitionView with Auto Layout
    private func transitionLayout() {
        addSubview(stackView)
        addSubview(barStackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        // Making barStackView below the Groove Front Camera & Inside the ImageView
        barStackView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.top.equalTo(snp.topMargin)
            make.height.equalTo(4)
        }
        
        // Making ImageView Taking 80% of the Entire Height
        imageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }
    
    // Function For Handling the Tap Depending on the Direction Area
    func handleTap(direction: Direction) {
        switch direction {
        case .left:
            barViews[index].reset()
            if barViews.indices.contains(index - 1) {
                barViews[index - 1].reset()
            }
            index -= 2
        case .right:
            barViews[index].complete()
            timer?.cancel()
            timer = nil
            start()
        }
    }
}
