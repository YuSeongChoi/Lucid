//
//  Stat+CoreDataProperties.swift
//  Lucid
//
//  Created by YuSeongChoi on 3/20/24.
//
//

import Foundation
import CoreData


extension Stat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stat> {
        return NSFetchRequest<Stat>(entityName: "Stat")
    }

    @NSManaged public var stat_name: String?
    @NSManaged public var stat_value: String?
    @NSManaged public var detail: Detail?

}

extension Stat : Identifiable {

}
