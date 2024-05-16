//
//  Local+CoreDataProperties.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 16/05/24.
//
//

import Foundation
import CoreData


extension Local {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Local> {
        return NSFetchRequest<Local>(entityName: "Local")
    }

    @NSManaged public var local_id: UUID?
    @NSManaged public var usuario_id: UUID?
    @NSManaged public var quant_idas: Int16

}

extension Local : Identifiable {

}
