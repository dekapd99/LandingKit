# LandingKit
LandingKit is iOS Library based app for Landing Pages with Storyboard, SwiftUI, SnapKit, & Combine Framework. This application is made so that I can Study iOS Frontend Science and iOS Library for personal interest.

### Preview
<p align="center">
  <a href="#" target="_blank"><img src="1.png" width="200"></a>
</p>

<!-- ABOUT THE FILE & FOLDER STRUCTURE -->
## Folder & File Structure
Here's the file and folder structure in LandingKit:

    .
    ├── Sources/LandingKit                      # Main Root Project: Library Configuration
    │   ├── Controller                          
    │   │   └── LandingViewController.swift     # Routes commands to the model and view parts
    │   │
    │   ├── Model
    │   │   ├── Direction.swift                 # Data Declaration for Tapped Area
    │   │   └── Slide.swift                     # Declaration of data & data type for Manages Data & Business Logic
    │   │
    │   ├── View
    │   │   ├── AnimatedBarView.swift           # Animation of Progressing Bar View
    │   │   ├── ButtonContainerView.swift       # Container of Buttons: Next & Get Started
    │   │   ├── TitleView.swift                 # Animation of Title View
    │   │   └── TransitionView.swift            # Transition Logic for Slides
    │   │
    │   └── LandingKit.swift                    # Public Interface: Where Client Consumes the Framework
    │
    ├── Tests/LandingKitTests                   # Unit Test Folder
    └── Package.swift                           # Package / Depedencies iOS Target

## Requirements

- iOS 15.0 or later
- Xcode 13.0 or later
- Swift 5.0 or later

## Installation
There are two ways to use LandingKit in your project:
- Using Swift Package Manager
- Manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

To integrate LandingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/dekapd99/LandingKit.git", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate LandingKit into your project manually.

---

## Usage

### Quick Start

```swift
import UIKit
import LandingKit // Import Public Interface to Consume the Framework

// This is Client in Project LandingCore who Consume the Framework of LandingKit Package
class ViewController: UIViewController {

    /**
     * Instances to connect with LandingKit
     * It's optional because it will able to init when it's Used & De-init when it isn't Used to free up space
     */
    private var landingKit: LandingKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delay Time for Getting Started Button
        DispatchQueue.main.async {
            self.landingKit = LandingKit(
                slides: [
                    .init(image: UIImage(named: "imSlide1")!,
                          title: "Personalized offers at 40,000+ places"),
                    .init(image: UIImage(named: "imSlide2")!,
                          title: "Stack your rewards every time you pay"),
                    .init(image: UIImage(named: "imSlide3")!,
                          title: "Enjoy now, FavePay Later"),
                    .init(image: UIImage(named: "imSlide4")!,
                          title: "Earn cashback with your physical card"),
                    .init(image: UIImage(named: "imSlide5")!,
                          title: "Save and Earn cashback with Deals or eCards")
                ],
                tintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0))
            self.landingKit?.delegate = self
            self.landingKit?.launchOnBoarding(rootVC: self)
        }
    }
  
    // MARK: - LandingKitDelegate {
    func nextButtonDidTap(atIndex index: Int) {
        print("Next Button is Tapped at Index: \(index)")
    }
    
    func getStartedButtonDidTap() {
        landingKit?.dismissOnBoarding()
        landingKit = nil
        transit(viewController: MainViewController())
    }
    
    // Stackoverflow Solutions for Transition Page
    private func transit(viewController: UIViewController) {
        let foregroundScenes = UIApplication.shared.connectedScenes.filter({
            $0.activationState == .foregroundActive
        })
        
        let window = foregroundScenes
            .map({ $0 as? UIWindowScene})
            .compactMap({ $0 })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first
        
        guard let uWindow = window else { return }
        uWindow.rootViewController = viewController
        
        UIView.transition(
            with: uWindow,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil)
    }
}
```
