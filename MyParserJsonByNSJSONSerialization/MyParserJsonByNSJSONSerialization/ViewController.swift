//
//  ViewController.swift
//  MyParserJsonByNSJSONSerialization
//
//  Created by qinjuan on 16/3/8.
//  Copyright © 2016年 qinjuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1 获取json文件路径
        let path=NSBundle.mainBundle().pathForResource("data", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        
        //3 解析json内容
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:[]) as! [String:AnyObject]
            // a 解析最外层的 "name"
            let name_C = json["name"] as! String
            print("\(name_C)")
            // b 解析  "province" 的所有内容
            if let provinces = json["province"] as? NSArray {//因为province的类型是数组[]
                print("一共有\(provinces.count)个省")
                for province in provinces{
                    let name=province["name"] as! String//因为province中name的类型是字符串String
                    if let cities=province["cities"] as? NSDictionary{//因为province中cities的类型是字典{}
                        let city = cities["city"] as! NSArray//因为cities中city的类型是数组[]
                        print("\(name)省的城市有")
                        for cityname in city {
                            print("\(cityname)")
                        }
                    }
                    print("")
                }
            }
            
            // c 解析data.json数据中某个省的名字和其中的某一个城市
            print("")
            if let provinces = json["province"] as? NSArray{
                if let province1 = provinces[1] as? NSDictionary{
                        let provincename=province1["name"] as! String
                    if let cities = province1["cities"] as? NSDictionary{
                        if let city = cities["city"] as? NSArray{
                            let cityname=city[1] as! String
                            print("第二个省\(provincename)的第二个城市是\(cityname)")
                        }
                    }
                }
            }
            
        }catch let error as NSError{
                print("解析出错: \(error.localizedDescription)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

