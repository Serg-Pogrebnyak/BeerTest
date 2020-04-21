//
//  CoreManager.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class CoreManager {
    static var shared = CoreManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var coreManagerContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getBreweriesFromCoreData() -> [Brewery] {
        do {
            return try self.coreManagerContext.fetch(Brewery.fetchRequest()) as! [Brewery]
        } catch {
            let nserror = error as NSError
            print("❌some error \(nserror), \(nserror.userInfo)")
            return [Brewery]()
        }
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        guard coreManagerContext.hasChanges else {return}
        coreManagerContext.perform {
            do {
                try self.coreManagerContext.save()
                print("✅saved")
            } catch {
                print("❌some error - save data")
            }
        }
    }
    
    func mergeDataWithLocalBreweries(jsonArray: [JSON], callback: @escaping ([Brewery]?) -> Void) {
        CoreManager.shared.coreManagerContext.perform {
            do {
                var returnedArray = [Brewery]()
                let localEntityArray = try CoreManager.shared.coreManagerContext.fetch(Brewery.fetchRequest()) as! [Brewery]
                
                for jsonObject in jsonArray {
                    let newObjectID = jsonObject["id"].stringValue
                    var hasElemetInStorage = false
                    for localEntity in localEntityArray {
                        if localEntity.id == newObjectID {
                            hasElemetInStorage = true
                            returnedArray.append(localEntity)
                            break
                        }
                    }
                    
                    if !hasElemetInStorage {
                        let newObject = Brewery.init(fromJson: jsonObject)
                        returnedArray.append(newObject)
                    }
                }
                CoreManager.shared.saveContext()
                callback(returnedArray)
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                callback(nil)
            }
        }
    }
}
