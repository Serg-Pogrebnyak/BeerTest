//
//  CoreManager.swift
//  Breweries list
//
//  Created by Sergey Pohrebnuak on 20.04.2020.
//  Copyright © 2020 Sergey Pohrebnuak. All rights reserved.
//

import Foundation
import CoreData

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
                print("❌some error when save data")
            }
        }
    }
}
