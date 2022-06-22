//
//  WorkOut+CoreDataProperties.swift
//  DataGym
//
//  Created by Narely Lima on 20/06/22.
//
//

import Foundation
import CoreData


extension WorkOut {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkOut> {
        return NSFetchRequest<WorkOut>(entityName: "WorkOut")
    }

    @NSManaged public var nameWorkOut: String?
    @NSManaged public var exercises: String?
    @NSManaged public var exercicios: Exercise?

}

extension WorkOut : Identifiable {

}
