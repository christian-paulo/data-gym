//
//  Exercise+CoreDataProperties.swift
//  DataGym
//
//  Created by Ieda Xavier on 22/06/22.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var charge: String?
    @NSManaged public var nameExercise: String?
    @NSManaged public var repetition: String?
    @NSManaged public var serie: String?
    @NSManaged public var treinos: WorkOut?

}

extension Exercise : Identifiable {

}
