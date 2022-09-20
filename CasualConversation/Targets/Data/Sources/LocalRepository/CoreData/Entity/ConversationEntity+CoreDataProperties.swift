//
//  ConversationEntity+CoreDataProperties.swift
//  Data
//
//  Created by Yongwoo Marco on 2022/07/29.
//  Copyright © 2022 pseapplications. All rights reserved.
//
//

import Foundation
import CoreData


extension ConversationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConversationEntity> {
        return NSFetchRequest<ConversationEntity>(entityName: "ConversationEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var members: [String]?
    @NSManaged public var recordFilePath: URL?
    @NSManaged public var recordedDate: Date?
    @NSManaged public var pins: [TimeInterval]?
    @NSManaged public var topic: String?

}

extension ConversationEntity : Identifiable {

}
