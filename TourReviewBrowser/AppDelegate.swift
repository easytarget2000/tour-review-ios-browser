import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        initScreen()
        return true
    }
    
    fileprivate func initScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TourReviewNavigationController()
        window?.makeKeyAndVisible()
    }
}

