//
//  Bookmark+CoreDataProperties.swift
//  Weather App
//
//  Created by Akshay  Chavan on 02/04/21.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var location: String?
    @NSManaged public var temprature: Double
    @NSManaged public var tempratureDesc: String?

}

extension Bookmark : Identifiable {

}
