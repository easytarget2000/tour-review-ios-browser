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
        let firstViewController = TourReviewCollectionViewController.newInstance(
            regionIDPath: "berlin-l17",
            tourIDPath: "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"
        )
        window?.rootViewController = firstViewController
        window?.makeKeyAndVisible()
    }
}

