//
//  Person+CoreDataProperties.swift
//  Core Data
//
//  Created by Milena Maia Araújo on 15/09/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int64
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var id: Int64

}

extension Person : Identifiable {

}
