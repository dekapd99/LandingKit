import UIKit

// Parent Observing the Client to Receive the Index of Slide
public protocol LandingKitDelegate: AnyObject {
    func nextButtonDidTap(atIndex index: Int)
    func getStartedButtonDidTap()
}

// Public Interface: Where Client Consumes the Framework
// We don't want client to access all our internal implementations
// But rather we want to provide a public interface for them to do that
public class LandingKit {
    
    // Properties / Dependencies for Init
    private let slides: [Slide]
    private let tintColor: UIColor

    public weak var delegate: LandingKitDelegate?
    
    /**
     * Instances to connect with LandingViewController & Passing the Properties / Dependencies
     * This will be invoke whenever the Init of LandingKit is Run
     * Lazy = LandingViewController only loads after this public init() is being initialize
     * and therefore its able to consume the Dependencies Models for Init
     */
    private lazy var landingViewController: LandingViewController = {
        let controller = LandingViewController(slides: slides, tintColor: tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.nextButtonDidTap = { [weak self] index in
            self?.delegate?.nextButtonDidTap(atIndex: index)
        }
        controller.getStartedButtonDidTap = { [weak self] in
            self?.delegate?.getStartedButtonDidTap()
        }
        return controller
    }()
    
    // Init for user can pass the Properties / Dependencies
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
    }

    // Passing RootViewController when LandingKit Launches to start everything
    public func launchOnBoarding(rootVC: UIViewController) {
        rootVC.present(landingViewController, animated: true, completion: nil)
    }
    
    // dismissOnBoarding to free up space when it isn't used anymore
    public func dismissOnBoarding() {
        
    }
}
