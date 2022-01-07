//
//  HealthStore.swift
//  stepOmeterSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 07/01/22.
//

import Foundation
import HealthKit




//MARK: For Calulation of Exact Date
extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear ,.weekOfYear], from: Date()))!
        
    }
}

//youtube : 17:38

class HealthStore {
    //Instance of HealthStore
    //for accessing number of steps : and to write down number of steps
    var healthStore : HKHealthStore?
    
    //For Query
    var query : HKStatisticsCollectionQuery?
    
    init(){
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    
    //MARK: For Authorization
    func requestAuthorization(completion : @escaping (Bool) -> Void){
        //To know what kind of data we are trying to authorize.
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        
        //Accessing HealthStore //unwrap version of healthstore
        guard let healthStore = self.healthStore else
        { return completion(false) }
        
        
        //Empty arry for data passing
        //To Read StepType
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(success)
        }

        
    }
    
    //MARK: function for calculation of steps
    func calculateSteps(completion : @escaping (HKStatisticsCollection?) -> Void){
        
        //Only for step count
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        //for starting date calender is used
        let startDate = Calendar.current.date(byAdding: .day,value: -7, to: Date())
        
        //MARK: (byAdding: .day,value: -7, to: Date()) // Past seven days to current date
        //Anchor Time and Date
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day : 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
         //To Get Samples
        
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        
        //initial result handler : when query is executed
        query!.initialResultsHandler = { query,statisticCollection, error in
            completion(statisticCollection)
        }
        
        //Execute Query
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    
    }
    
}
 
