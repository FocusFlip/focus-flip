//
//  IntentHandler.swift
//  Shortcuts
//
//  Created by Arthur Becker on 10.01.24.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if(intent is TriggerAppOpenedIntent){
            return TriggerAppOpenedIntentHandler()
        }
        
        if (intent is HealthyAppClosedIntent) {
            return HealthyAppClosedIntentHandler()
        }
        
        return self
    }
    
}
