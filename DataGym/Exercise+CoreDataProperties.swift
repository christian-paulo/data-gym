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

    @NSManaged public var serie: String?
    @NSManaged public var nameExercise: String?
    @NSManaged public var repetition: String?
    @NSManaged public var charge: String?
    @NSManaged public var treinos: WorkOut?

}

extension Exercise : Identifiable {

}