//
//  Task+CoreDataProperties.swift
//  ToDoListCoreData2
//
//  Created by Артур Дохно on 25.02.2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?

}

extension Task : Identifiable {

}
