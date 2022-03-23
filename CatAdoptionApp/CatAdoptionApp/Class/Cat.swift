//
//  Cat.swift
//  CatAdoptionApp
//
//  Created by administrator on 2022. 03. 05..
//  Copyright © 2022. administrator. All rights reserved.
//

import Foundation
import RealmSwift

class Cat : Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name:String = ""
    @objc dynamic var birthDate:NSDate = NSDate()
    @objc dynamic var arriveToShelter: NSDate = NSDate()
    @objc dynamic var adoptionDate:NSDate?
    @objc dynamic var ownerName:String?
    @objc dynamic var neuteringDate:NSDate = NSDate()
    @objc dynamic var gender = false // false female true male
    @objc dynamic var adopted = false
    
    convenience init(name:String,birthDate:NSDate,arriveToShelter:NSDate,adoptionDate:NSDate? = nil,ownerName:String? = nil,neuteringDate:NSDate,gender:Bool) {
            self.init()
            self.name=name
            self.birthDate=birthDate
            self.adoptionDate=adoptionDate
            self.arriveToShelter = arriveToShelter
            self.ownerName=ownerName
            self.neuteringDate=neuteringDate
            self.gender=gender
    }
    override class func primaryKey() -> String {
        return "id"
    }
    
    
}
