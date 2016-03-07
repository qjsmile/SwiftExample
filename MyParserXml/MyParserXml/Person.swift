//
//  person.swift
//  MyParserXml
//
//  Created by qinjuan on 16/3/6.
//  Copyright © 2016年 qinjuan. All rights reserved.
//

import Foundation
class Person:NSObject{
    var id:String=""
    var name:String=""
    var age:String=""
    init(id:String,name:String,age:String) {
        self.id=id
        self.name=name
        self.age=age
    }
    override init(){}
}