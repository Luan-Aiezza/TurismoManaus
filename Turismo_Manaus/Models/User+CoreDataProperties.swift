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

    @NSManaged public var user_id: UUID?
    @NSManaged public var possui: Visited_Point?

}

extension User : Identifiable {

}
