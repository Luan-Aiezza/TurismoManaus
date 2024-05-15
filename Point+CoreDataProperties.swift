//
//  Point+CoreDataProperties.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 15/05/24.
//
//

import Foundation
import CoreData


extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var user_id: UUID?
    @NSManaged public var visited_point_id: UUID?
    @NSManaged public var quant_idas: Int16
    @NSManaged public var pertence: User?

}

extension Point : Identifiable {

}
