//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by qinjuan on 15-3-20.
//  Copyright (c) 2015年 qinjuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var timer:NSTimer!//设置图片循环滚动的间隔时间的定时器
    var pageViews: [UIImageView?] = []//存放展示图片的imageview
    let pageCount:NSInteger = 4;//页面数
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //加载图片数组
        let imageW:CGFloat=self.scrollView.frame.size.width
        let imageH:CGFloat=self.scrollView.frame.size.height
        let imageY:CGFloat=0
        var imageView:UIImageView=UIImageView()
        for index in 0..<pageCount{
            var imageView:UIImageView = UIImageView();
            let imageX:CGFloat = CGFloat(index) * imageW;
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            let name:NSString = NSString(format: "photo%d", index+1);
            imageView.image = UIImage(named: name);
            //设置图片内容的显示模式
            imageView.contentMode = UIViewContentMode.ScaleToFill
            self.scrollView.showsHorizontalScrollIndicator = false;
            self.scrollView.addSubview(imageView);
        }
        //初始化scrollView
        let contentW:CGFloat = imageW * CGFloat(pageCount);
        self.scrollView.contentSize = CGSizeMake(contentW, 0);//scrollView可滚动的区域；
        self.scrollView.pagingEnabled = true; //设置是否可以进行画面切换
        self.scrollView.delegate = self;
        //初始化pageControl
        self.pageControl.currentPage=0
        self.pageControl.numberOfPages=pageCount
        //循环展示图片
        self.addTimer()
//        self.pageControl.addTarget(self, action: "pageControlAction:", forControlEvents:UIControlEvents.ValueChanged)
//        println("eheh")
//        
    }
    
//    func pageControlAction(sender: UIPageControl) {
//        println("pageControlAction:\(sender.currentPage)")
//    }
    
    func addTimer(){//定时器相应函数-》nextImage函数
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextImage:", userInfo: nil, repeats: true);
    }
    func removeTimer(){
        self.timer.invalidate();
    }
    func nextImage(sender:AnyObject!){
        var page:Int = self.pageControl.currentPage;
        if(page == 3){
            page = 0;
        }else{
            ++page;
        }
        let x:CGFloat = CGFloat(page) * self.scrollView.frame.size.width;
        self.scrollView.contentOffset = CGPointMake(x, 0);
    }
    
    //滑动结束时
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollviewW:CGFloat = scrollView.frame.size.width;
        let x:CGFloat = scrollView.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW);
        self.pageControl.currentPage = page;
    }
    //准备开始滑动时，定时器清除
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer();
    }
    
    //滑动结束后，重新加载定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

