//
//  Class+CoreDataProperties.swift
//  DataGym
//
//  Created by Narely Lima on 07/06/22.
//
//

import Foundation
import CoreData


extension Class {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Class> {
        return NSFetchRequest<Class>(entityName: "Class")
    }

    @NSManaged public var day_week: String?
    @NSManaged public var hour: String?
    @NSManaged public var name: String?
    @NSManaged public var semester_school: String?
    @NSManaged public var teacher: Teacher?

}

extension Class : Identifiable {

}
