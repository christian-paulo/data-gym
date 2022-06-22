//
//  Teacher+CoreDataProperties.swift
//  DataGym
//
//  Created by Ieda Xavier on 22/06/22.
//
//

import Foundation
import CoreData


extension Teacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teacher> {
        return NSFetchRequest<Teacher>(entityName: "Teacher")
    }

    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var classes: Class?

}

extension Teacher : Identifiable {

}
