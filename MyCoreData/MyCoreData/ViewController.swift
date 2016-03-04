//
//  ViewController.swift
//  MyCoreData
//
//  Created by qinjuan on 16/3/4.
//  Copyright © 2016年 qinjuan. All rights reserved.
//

import UIKit
import CoreData
//import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.saveCoreDate()//创建对象并保存数据
        self.fetchCoreData()//查询对象并进行修改和删除操作

    }
    //添加数据
    func saveCoreDate(){
        //加载AppDelegate
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        //获取管理的上下文
        let context = appDel.managedObjectContext
        //创建一个实例并给属性赋值
        //不清楚为什么注释的这种方式不可以
        let people = NSEntityDescription.insertNewObjectForEntityForName("People", inManagedObjectContext: context) as! People
        people.id = 2
        people.name = "小红"
        people.age = 12
        //下面这种赋值方式也可以的
//        let entity = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
//        let people = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
//        people.setValue(1, forKey: "id")
//        people.setValue("小明", forKey: "name")
//        people.setValue(10, forKey: "age")
        //保存数据
        do {
            try context.save()
            print("保存成功")
        } catch let error{
            print("context can't save!, Error: \(error)")
        }
    }
    func fetchCoreData (){
        //加载AppDelegate
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        //获取管理的上下文
        let context = appDel.managedObjectContext
        // 声明数据请求实体
        let fetchRequest = NSFetchRequest(entityName: "People")
       
//        let predicate = NSPredicate(format:"id=1")  //设置查询条件按照id查找 不设置查询条件，则默认全部查找
//        fetchRequest.predicate=predicate
        //执行查询操作
        do {
            let peopleList =
            try context.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            print("打印查询结果")
            for person in peopleList as! [People] {
                print("查询到的人是\(person.name!)")
                //修改操作:将查询到的结果修改后，再调用context.save()保存即可
                if (person.name == "小红"){
                    person.name="小花"
                }
                //删除操作:将查询到的额结果删除后，再调用context.save()保存即可
                if (person.name == "小明"){
                    context.deleteObject(person)
                }
            }
        }catch let error{
            print("context can't fetch!, Error: \(error)")
        }
        do {
            try context.save()
            print("保存成功")
        } catch let error{
            print("context can't save!, Error: \(error)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

