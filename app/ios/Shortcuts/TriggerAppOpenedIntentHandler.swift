//
//  TriggerAppOpenedIntentHandler.swift
//  Runner
//
//  Created by Arthur Becker on 10.01.24.
//

import Foundation


class TriggerAppOpenedIntentHandler: NSObject, TriggerAppOpenedIntentHandling {
  func handle(intent: TriggerAppOpenedIntent, completion: @escaping (TriggerAppOpenedIntentResponse) -> Void) {
    
    // TODO: add all necessary trigger apps
    let triggerApp = intent.triggerApp
      let appName : String?
      switch(triggerApp){
      case .instagram:
          appName = "Instagram"
          break
      case .facebook:
          appName = "Facebook"
          break
      default:
          fatalError("[TriggerAppOpenedIntentHandler] The chosen trigger app is not supported")
      }
    
    
    let userActivity = NSUserActivity(activityType: "TriggerAppOpened")
    userActivity.title = "Trigger App Opened"
    userActivity.userInfo = [
        "appName": appName!
    ]
      
    let response = TriggerAppOpenedIntentResponse(code: .continueInApp, userActivity: userActivity)
    completion(response)
  }
  
    func resolveTriggerApp(for intent: TriggerAppOpenedIntent, with completion: @escaping (TriggerAppResolutionResult) -> Void) {
        var result: TriggerAppResolutionResult = .unsupported()
        
        defer { completion(result) }
        
        let triggerApp = intent.triggerApp
        if triggerApp != .unknown {
            result = .success(with: triggerApp)
        }
    }
}
