//
//  InterventionController.swift
//  Runner
//
//  Created by Arthur Becker on 15.01.24.
//

import Foundation

class InterventionController {
    var groupName : String
    var sharedContainer : UserDefaults
    
    // Keys
    let _disableInterventionForKey : String = "disableInterventionFor"
    let _disableInterventionFromTimeKey : String = "disableInterventionFromTime"
    
    /// The duration of the time window when an intervention is disabled
    let _disabledInterventionDuration = 7.0
    
    init(groupName: String = "group.QL32TQBL82.com.example.quezzy") {
        print("[InterventionController] Initialization started")
        
        self.groupName = groupName
        
        if let userDefaults = UserDefaults(suiteName: groupName) {
            self.sharedContainer = userDefaults
        }
        else {
            fatalError("[InterventionController] Shared container is not accessible")
        }
        
    }
    
    func disableIntervention(appName: String) -> Void {
        let timestamp : Double = Date().timeIntervalSinceReferenceDate
        
        self.sharedContainer.set(appName, forKey: _disableInterventionForKey)
        self.sharedContainer.set(timestamp, forKey: _disableInterventionFromTimeKey)
        self.sharedContainer.synchronize()
    }
    
    func isInterventionRequired(appName: String) -> Bool {
        if let savedAppName = self.sharedContainer.string(forKey: _disableInterventionForKey) {
            if(savedAppName != appName){
                return true
            }
            
            let timestamp = self.sharedContainer.double(forKey: _disableInterventionFromTimeKey)
            if (timestamp.isNaN) {
                return true
            }
            
            let currentTimestamp : Double = Date().timeIntervalSinceReferenceDate
            if(currentTimestamp < timestamp + _disabledInterventionDuration){
                return false
            }
            else {
                return true
            }
        }
        else {
            return true
        }
        
    }
    
    
    
    
}
