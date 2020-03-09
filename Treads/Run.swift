//
//  Run.swift
//  Treads
//
//  Created by Jacob Luetzow on 6/19/17.
//  Copyright © 2017 Jacob Luetzow. All rights reserved.
//


//
//  Run.swift
//  TriniRun
//
//  Created by Joseph on 1/18/20.
//  Copyright © 2020 Coconut Tech LLc. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {         //inherits from Object
    
    /* START CREATE REALM OBJECT: Data Model to manage data for runs.
       NOTE: With Realm - we MUST create a NEW instance EVERYTIME we WRITE and everytimg we READ
       ALSO: Writes to Realm is asynchronous - so we need to take it off the main Thread - and instead use a serial dispatch  asynchronous queue
       we need to be sure we are calling it from the same Thread */
    //@objc dynamic public private(set) var id: String = ""
    dynamic public private(set) var id: String = ""

    //@objc dynamic public private(set) var id: String = ""             /*sets a realm dynamic variable caled ID.  Required - dynamic allows the Realm Backend to dynamically update any and all realm database vars as needed.  Must be dynamic.  The set is data encapsulation.  In this case we can GET data from any source but can only SET within our database file.  Same for all the other variables*/
    /*NOTE: Added @objc to Realm vars as without app crashed due to primary key not set on object run error */
    //@objc dynamic public private(set) var date = NSDate()     //allows for easy sorting by date.  NSDate does have timestamp if needed for display
    //@objc dynamic public private(set) var pace = 0
    //@objc dynamic public private(set) var distance = 0.0
    //@objc dynamic public private(set) var duration = 0
    
    
    dynamic public private(set) var date = NSDate()     //allows for easy sorting by date.  NSDate does have timestamp if needed for display
    dynamic public private(set) var pace = 0
    dynamic public private(set) var distance = 0.0
    dynamic public private(set) var duration = 0
    /*NOTE: Type List and Realm properties cannot be declared as dynamic as these typs are generic properties*/
    public private(set) var locations = List<Location>()      //Initially an empty of locations list to track path of the run
    
    
    override class func primaryKey() -> String {
        return "id"                                     //required: realm must know what the PK is. Any previously assigned VAR can be the PK
    }
    
    override class func indexedProperties() -> [String] { //Needed to allow searching. NOTE: Double Type is NOT allowed so cannot add <distance> variable
        return ["pace", "date", "duration"]
    }
    
    /* Convenience method here is like a constructor: Required*/
    convenience  init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()        //generates unique object IDs in lowercase - lowercase not required but I prefer
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
    }
    
    /* Static func addRunToRealm -CALLED in endRun() in CurrentRunVC.swift - create static as we want a single instance that won't be overwritten */
    static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>){
        REALM_QUEUE.sync {                          //Created in Utilities->Constants - this allows us to run Realm on its own async Thread
       
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations) //passed in from previous VC
            
            do {
                let realm = try Realm(configuration: RealmConfig.runDataConfig)  //Updated Realm() to Realm( with our custom Realm Config as defined in Utilities RealmConfig.swift)
                print(Realm.Configuration.defaultConfiguration.fileURL!)


                    try realm.write {
                        realm.add(run)
                   // try realm.commitWrite()             //not mandatory but preferred to confirm the commit You only need to call self.realm.commitWrite() when you have previously called self.realm.beginWrite()
                    }
                } catch{
                    debugPrint("Error adding run to realm!")
            }
      }
    }
    
    /* Get all runs from Realm DB*/
    static func getAllRuns() ->Results<Run>? {
        print("In Get All Runs in Run.swift model")
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)  //Updated Realm() to Realm( with our custom Realm Config as defined in Utilities RealmConfig.swift)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            print(Realm.Configuration.defaultConfiguration.fileURL!)  //The path of the Realm Database

            return runs
        }catch{
            debugPrint("No data found in realm db")

            return nil                            //Return Nil if there is no data in database
        }
        
    }
    
    
    /* Get a single run by primary key id as ued in BeginRunVC.swift*/
    static func getRun(byId id: String) -> Run? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            return realm.object(ofType: Run.self, forPrimaryKey: id)
                        
        } catch {
            return nil
        }
        
    }
    
    /* END CREATE REALM OBJECT*/
}


/*
import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var date = NSDate()
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    public private(set) var locations = List<Location>()
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
    }
    
    static func addRunToRealm(pace: Int, distance: Double, duration: Int, locations: List<Location>) {
        REALM_QUEUE.sync {
            let run = Run(pace: pace, distance: distance, duration: duration, locations: locations)
            do {
                let realm = try Realm(configuration: RealmConfig.runDataConfig)
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite()
                }
            } catch {
                debugPrint("Error adding run to realm!")
            }
        }
    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            return runs 
        } catch {
            return nil
        } 
    }
    
    
    
  
    
    
    
    
    
    
    
    
    
    
}
  */
