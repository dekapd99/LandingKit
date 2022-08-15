import UIKit

// Public Interface: Where Client Consumes the Framework
// We don't want client to access all our internal implementations
// But rather we want to provide a public interface for them to do that
public class LandingKit {
    
    // Dependencies Models for Init
    private let slides: [Slide]
    private let tintColor: UIColor

    // Instances for Connection to LandingViewController & Passing Dependencies
    // This will be run whenever the initialize of LandingKit in Run
    // Lazy Loading means so that this LandingViewController only loads after this public init() is being being initialize and therefore its able to consume the Dependencies Models for Init
    private lazy var landingViewController: LandingViewController = {
        let controller = LandingViewController(slides: slides, tintColor: tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        return controller
    }()
    
    // Initialize this LandingKit in Main Thread
    // This is the place where the user can pass the Models Information
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
    }
    
    // When the client launches our LandingKit they have to pass in the Current Controller which is RootViewController
    public func launchOnBoarding(rootVC: UIViewController) {
        rootVC.present(landingViewController, animated: true, completion: nil)
    }
    
    // If you can launchOnBoarding, you should be able to dismissOnBoarding to free up space
    public func dismissOnBoarding() {
        
    }
}
