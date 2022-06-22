//
//  WorkOut+CoreDataProperties.swift
//  DataGym
//
//  Created by Ieda Xavier on 22/06/22.
//
//

import Foundation
import CoreData


extension WorkOut {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkOut> {
        return NSFetchRequest<WorkOut>(entityName: "WorkOut")
    }

    @NSManaged public var exercises: String?
    @NSManaged public var nameWorkOut: String?
    @NSManaged public var exercicios: Exercise?

}

extension WorkOut : Identifiable {

}
