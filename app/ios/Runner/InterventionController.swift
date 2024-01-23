//
//  InterventionController.swift
//  Runner
//
//  Created by Arthur Becker on 15.01.24.
//

import Foundation

// TODO: refactor
class InterventionController {
    var groupName : String
    var sharedContainer : UserDefaults
    
    // Keys
    let _disableInterventionForKey : String = "disableInterventionFor"
    let _disableInterventionFromTimeKey : String = "disableInterventionFromTime"
    
    let _healthyAppInterventionStateUpdateTime : String = "healthyAppInterventionStateUpdateTime"
    let _healthyAppInterventionStateType : String = "healthyAppInterventionStateType"
    let _healthyAppInterventionRequiredTime : String = "healthyAppInterventionRequiredTime"
    
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
    
    func updateHealthyAppInterventionState(stateType: HealthyAppInterventionStateType, requiredInterventionTimeInSeconds: Double?) {
        assert(stateType != .started || requiredInterventionTimeInSeconds != nil)
        
        let timestamp : Double = Date().timeIntervalSinceReferenceDate
        
        self.sharedContainer.set(stateType.rawValue, forKey: _healthyAppInterventionStateType)
        self.sharedContainer.set(timestamp, forKey: _healthyAppInterventionStateUpdateTime)
        self.sharedContainer.set(requiredInterventionTimeInSeconds, forKey: _healthyAppInterventionRequiredTime)
        self.sharedContainer.synchronize()
        
    }
    
    func getHealthyAppInterventionState() -> HealthyAppInterventionState {
        if let stateTypeRaw = self.sharedContainer.string(forKey: _healthyAppInterventionStateType){
            let timestamp = self.sharedContainer.double(forKey: _healthyAppInterventionStateUpdateTime)
            if(!timestamp.isNaN){
                let stateType = HealthyAppInterventionStateType(rawValue: stateTypeRaw)
                
                switch stateType {
                case .started:
                    let requiredTime = self.sharedContainer.double(forKey: _healthyAppInterventionRequiredTime)
                    // TODO: check if NaN value is a possible outcome of `requiredTime`
                    return HealthyAppInterventionStarted(timestamp: timestamp, requiredTimeInSeconds: requiredTime)
                case .interrupted:
                    return HealthyAppInterventionInterrupted(timestamp: timestamp)
                case .reward:
                    return HealthyAppInterventionReward(timestamp: timestamp)
                case .inactive:
                    return HealthyAppInterventionInactive(timestamp: timestamp)
                case .none:
                    let state = HealthyAppInterventionInactive(timestamp: 0)
                    return state
                }
                
                
            }
            else {
                let state = HealthyAppInterventionInactive(timestamp: 0)
                return state
            }
        }
        else {
            let state = HealthyAppInterventionInactive(timestamp: 0)
            return state
        }
    }
    
    func isRequiredTimeSatisfied(state: HealthyAppInterventionStarted) -> Bool {
        let currentTimestamp : Double = Date().timeIntervalSinceReferenceDate
        if(currentTimestamp > state.timestamp + state.requiredTimeInSeconds){
            return true
        }
        else {
            return false
        }
    }
    
    
}

enum HealthyAppInterventionStateType : String {
    case started = "started", interrupted = "interrupted", reward = "reward", inactive = "inactive"
}


// Healthy app intervention states
protocol HealthyAppInterventionState {
    var timestamp : TimeInterval { get }
    var type : HealthyAppInterventionStateType { get }
}

class HealthyAppInterventionStarted : HealthyAppInterventionState {
    var timestamp: TimeInterval
    var type: HealthyAppInterventionStateType = .started
    let requiredTimeInSeconds : Double
    
    init(timestamp: TimeInterval, requiredTimeInSeconds: Double){
        self.timestamp = timestamp
        self.requiredTimeInSeconds = requiredTimeInSeconds
    }
}

class HealthyAppInterventionInterrupted : HealthyAppInterventionState {
    var timestamp: TimeInterval
    var type: HealthyAppInterventionStateType = .interrupted
    
    init(timestamp: TimeInterval){
        self.timestamp = timestamp
    }
}

class HealthyAppInterventionReward : HealthyAppInterventionState {
    var timestamp: TimeInterval
    var type: HealthyAppInterventionStateType = .reward
    
    init(timestamp: TimeInterval){
        self.timestamp = timestamp
    }
}

class HealthyAppInterventionInactive : HealthyAppInterventionState {
    var timestamp: TimeInterval
    var type: HealthyAppInterventionStateType = .inactive
    
    init(timestamp: TimeInterval){
        self.timestamp = timestamp
    }
}
