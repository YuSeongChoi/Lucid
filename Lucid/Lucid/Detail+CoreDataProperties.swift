//
//  Detail+CoreDataProperties.swift
//  Lucid
//
//  Created by YuSeongChoi on 3/20/24.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var character_class: String?
    @NSManaged public var date: String?
    @NSManaged public var remain_ap: Int64
    @NSManaged public var final_stat: NSSet?

}

// MARK: Generated accessors for final_stat
extension Detail {

    @objc(addFinal_statObject:)
    @NSManaged public func addToFinal_stat(_ value: Stat)

    @objc(removeFinal_statObject:)
    @NSManaged public func removeFromFinal_stat(_ value: Stat)

    @objc(addFinal_stat:)
    @NSManaged public func addToFinal_stat(_ values: NSSet)

    @objc(removeFinal_stat:)
    @NSManaged public func removeFromFinal_stat(_ values: NSSet)

}

extension Detail : Identifiable {

}
