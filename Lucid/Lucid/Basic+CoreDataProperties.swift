//
//  Basic+CoreDataProperties.swift
//  Lucid
//
//  Created by YuSeongChoi on 3/20/24.
//
//

import Foundation
import CoreData


extension Basic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Basic> {
        return NSFetchRequest<Basic>(entityName: "Basic")
    }

    @NSManaged public var character_class: String?
    @NSManaged public var character_class_level: String?
    @NSManaged public var character_exp: Int64
    @NSManaged public var character_exp_rate: String?
    @NSManaged public var character_gender: String?
    @NSManaged public var character_guild_name: String?
    @NSManaged public var character_image: String?
    @NSManaged public var character_level: Int64
    @NSManaged public var character_name: String?
    @NSManaged public var date: String?
    @NSManaged public var world_name: String?

}

extension Basic : Identifiable {

}
