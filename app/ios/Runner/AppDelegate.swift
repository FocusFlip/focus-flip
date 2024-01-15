import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    initShortcutsChannel()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application (
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        userActivity.interaction?.donate(completion: { error in
            if let error = error {
                print("Donate Interaction with error: \(error.localizedDescription)")
            } else {
                if userActivity.activityType == "TriggerAppOpened" {
                    self.triggerAppOpened(appName: userActivity.userInfo!["appName"] as! String)
                }
                else {
                    // TODO: check, if no other activity types are required by any of plugins/system
                    fatalError("[AppDelegate] This activity type is not supported by the app")
                }
            }
        })
        return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    
    func triggerAppOpened(appName: String){
        print("[AppDelegate] A trigger app has been opened")
        
        // Go back to the main thread because Flutter requires it for
        // MethodChannel communication
        DispatchQueue.main.async {
            print("[AppDelegate] invoke method `triggerAppOpened` on main thread")
            AppDelegate.shortcutChannel?.invokeMethod("triggerAppOpened", arguments: [ "appName" : appName ])
        }
    }
    
    static var shortcutChannel : FlutterMethodChannel?;
    
    func initShortcutsChannel(){
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        AppDelegate.shortcutChannel = FlutterMethodChannel(name: "com.example.quezzy/shortcuts",
                                                  binaryMessenger: controller.binaryMessenger)
        
        print("[AppDelegate] shortcutChannel has been initialized")
    }
    
}
