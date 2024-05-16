//
//  Visited_Point+CoreDataProperties.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 16/05/24.
//
//

import Foundation
import CoreData


extension Visited_Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Visited_Point> {
        return NSFetchRequest<Visited_Point>(entityName: "Visited_Point")
    }

    @NSManaged public var point_id: UUID?
    @NSManaged public var quant_idas: Int16
    @NSManaged public var user_id: UUID?

}

extension Visited_Point : Identifiable {

}
