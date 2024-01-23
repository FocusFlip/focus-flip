//
//  HealthyAppClosedIntentHandler.swift
//  Shortcuts
//
//  Created by Arthur Becker on 23.01.24.
//

import Foundation

/// This handler is run when a healthy app is closed and responsible for verifying whether:
/// - The healthy app was opened as a task from FocusFlip
/// - The healthy app was not left between the start of the task and the execution of this handler
/// - The healthy app has been opened for long enouph
class HealthyAppClosedIntentHandler: NSObject, HealthyAppClosedIntentHandling {
    func handle(intent: HealthyAppClosedIntent, completion: @escaping (HealthyAppClosedIntentResponse) -> Void) {
        // TODO: remove all notifications to prevent occasional granting access to a trigger app
        
        print("[HealthyAppClosedIntentHandler] handle() invoked")
        
        let controller = InterventionController()
        
        let interventionState = controller.getHealthyAppInterventionState();
        if(interventionState is HealthyAppInterventionStarted){
            if(controller.isRequiredTimeSatisfied(state: interventionState as! HealthyAppInterventionStarted)){
                controller.updateHealthyAppInterventionState(stateType: .reward, requiredInterventionTimeInSeconds: 0)
            }
            else {
                controller.updateHealthyAppInterventionState(stateType: .interrupted, requiredInterventionTimeInSeconds: 0)
            }
        }
        
        let response = HealthyAppClosedIntentResponse(code: .success, userActivity: nil)
        completion(response)
    }
}
