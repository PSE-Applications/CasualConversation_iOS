//
//  NoteEntity+CoreDataProperties.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/07/29.
//  Copyright © 2022 pseapplications. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var original: String?
    @NSManaged public var translation: String?
    @NSManaged public var category: String?
    @NSManaged public var references: [UUID]?
    @NSManaged public var createdDate: Date?

}

extension NoteEntity : Identifiable {

}
