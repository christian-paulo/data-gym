//
//  Students+CoreDataProperties.swift
//  DataGym
//
//  Created by Ieda Xavier on 23/06/22.
//
//

import Foundation
import CoreData


extension Students {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Students> {
        return NSFetchRequest<Students>(entityName: "Students")
    }

    @NSManaged public var name: String?
    @NSManaged public var restricoes: String?
    @NSManaged public var classesaluno: Class?

}

extension Students : Identifiable {

}
