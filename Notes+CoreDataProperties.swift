//
//  Notes+CoreDataProperties.swift
//  appNotes
//
//  Created by Mohan K on 13/03/23.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var creationdate: Date?
    @NSManaged public var datastring: String?
    @NSManaged public var id: Int16
    @NSManaged public var color: String?
    @NSManaged public var isedited: Bool
    @NSManaged public var isPinned: Bool
    @NSManaged public var colourstype: String?

}

extension Notes : Identifiable {

}
