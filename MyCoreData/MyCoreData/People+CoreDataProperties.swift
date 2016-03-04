//
//  People+CoreDataProperties.swift
//  MyCoreData
//
//  Created by qinjuan on 16/3/4.
//  Copyright © 2016年 qinjuan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
extension People {

    @NSManaged var age: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?

}
