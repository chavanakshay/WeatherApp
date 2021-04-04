//
//  CoreDataManager.swift
//  Weather App
//
//  Created by Akshay  Chavan on 02/04/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    private var appDelegate:AppDelegate?
    
    private init() {
        DispatchQueue.main.async {
            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        }
    }
    
    func getManagedObject(for entity:String) -> NSManagedObject? {
        var entityObj:NSManagedObject?
        guard let context = appDelegate?.persistantContainer.viewContext else{return nil}
        let entity = NSEntityDescription.entity(forEntityName: entity, in: context)
        entityObj = NSManagedObject(entity: entity!, insertInto: context)
        return entityObj
    }
    
    func saveObject(object:NSManagedObject){
        guard let context = self.appDelegate?.persistantContainer.viewContext else{return}
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetchObject(from entity:String,using predicate:NSPredicate,completionHandle:@escaping(NSManagedObject?)->Void)  {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = predicate
            fetchRequest.returnsObjectsAsFaults = false
            if self.appDelegate == nil {
                self.appDelegate = UIApplication.shared.delegate as? AppDelegate
            }
            guard let context = self.appDelegate?.persistantContainer.viewContext else{return}
            let result = try context.fetch(fetchRequest)
            completionHandle(result.first as? NSManagedObject)
        } catch {
            print("Failed")
        }
    }
    
    func deleteObject(object:NSManagedObject,completionHandle:@escaping()->Void){
        if self.appDelegate == nil {
            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        }
        guard let context = self.appDelegate?.persistantContainer.viewContext else{return}
        context.delete(object)
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        completionHandle()
    }
    
    func fetchAllObjects(from entity:String,completionHandle:@escaping([NSManagedObject])->Void){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:entity)
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        if self.appDelegate == nil {
            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        }
        guard let context = self.appDelegate?.persistantContainer.viewContext else{return}
        
        do {
            let result = try context.fetch(request)
            completionHandle(result as! [NSManagedObject])
        } catch {
            print("Failed")
        }
    }
}

