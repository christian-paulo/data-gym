//
//  Exercise+CoreDataProperties.swift
//  DataGym
//
//  Created by Narely Lima on 20/06/22.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var serie: Int16
    @NSManaged public var nameExercise: String?
    @NSManaged public var repetition: Int32
    @NSManaged public var charge: String?
    @NSManaged public var treinos: WorkOut?

}

extension Exercise : Identifiable {

}
