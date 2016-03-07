//
//  PersonParser.swift
//  MyParserXml
//
//  Created by qinjuan on 16/3/6.
//  Copyright © 2016年 qinjuan. All rights reserved.
//

import Foundation
class PersonParser:NSObject,NSXMLParserDelegate{
    var personList:[Person] = []//用于存放Person.xml文件中person的列表
    var isUser:Bool = false //判断是否解析到开始标签<User>
    var currentElementValue:String! //当前解析的标签的值
    var currentID:String=""//用于存放当前<id>的值
    var currentName:String=""//用于存放当前<name>的值
    var currentAge:String=""//用于存放当前<age>的值
    override init() {}
    
    //解析到开始标签<> 比如<User> <id> <name>
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        if(elementName == "User"){ //开始解析一个User
            isUser = true
        }
    }
    
    //解析到开始标签或者是结束标签的时候，再来执行这个函数获取标签的内容
    //比如<name>小明1</name>  开始标签 name值是:小明1 结束标签</name> 值是空“”
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let str = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())//移除空格和空行
            self.currentElementValue=str
    }
    //解析到结束标签<> 比如</User> </id> </name>
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(isUser == true){ //解析User里面的标签
            if(elementName == "id"){
                currentID = self.currentElementValue
             }else if(elementName == "name"){
                currentName = self.currentElementValue
             }else if(elementName == "age"){
                currentAge = self.currentElementValue
             }
        }
        if(isUser == true){
            if elementName == "User" { //表示当前的一个User已经解析完毕，构造对象并存储
                let person:Person=Person()
                person.id=currentID
                person.name=currentName
                person.age=currentAge
                personList.append(person)
                isUser=false
            }
        }
    }

    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("解析错误")
        
    }
}

