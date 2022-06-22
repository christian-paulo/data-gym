//
//  Class+CoreDataProperties.swift
//  DataGym
//
//  Created by Ieda Xavier on 22/06/22.
//
//

import Foundation
import CoreData


extension Class {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Class> {
        return NSFetchRequest<Class>(entityName: "Class")
    }

    @NSManaged public var dayWeek: String?
    @NSManaged public var hour: String?
    @NSManaged public var name: String?
    @NSManaged public var semesterSchool: String?

}

extension Class : Identifiable {

}
