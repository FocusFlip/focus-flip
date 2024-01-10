//
//  TriggerAppOpenedIntentHandler.swift
//  Runner
//
//  Created by Arthur Becker on 10.01.24.
//

import Foundation


class TriggerAppOpenedIntentHandler: NSObject, TriggerAppOpenedIntentHandling {
  func handle(intent: TriggerAppOpenedIntent, completion: @escaping (TriggerAppOpenedIntentResponse) -> Void) {
    /*let firstNumber = intent.firstNumber!
    let secondNumber = intent.secondNumber!
    let result = NSNumber(value: firstNumber.intValue + secondNumber.intValue)*/
    
    let userActivity = NSUserActivity(activityType: "TriggerAppOpened")
    userActivity.title = "Trigger App Opened"
      
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
