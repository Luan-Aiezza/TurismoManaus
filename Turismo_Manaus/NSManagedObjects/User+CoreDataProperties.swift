//
//  User+CoreDataProperties.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 16/05/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var usuario_id: UUID?
    @NSManaged public var possui: User?

}

extension User : Identifiable {

}
