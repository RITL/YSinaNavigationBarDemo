//
//  ViewController.swift
//  YSinaNavigationBarDemo
//
//  Created by YueWen on 16/3/9.
//  Copyright © 2016年 YueWen. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomHeaderViewDelegate{

    var tableView: UITableView!
    var imageView: UIImageView!
    
    var imageHeight:CGFloat?
    var imageDistance:CGFloat?
    
    let barColor = UIColor.orangeColor()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //设置导航栏的属性
        self.navigationController?.navigationBar.setViewColor(barColor.colorWithAlphaComponent(0.0))
        
        //设置列表属性
        tableView = UITableView(frame: self.view.bounds)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        //设置显示图片的视图
        imageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 100))
        imageView.contentMode = .ScaleAspectFill
        imageView.image = UIImage(named: "backGround.jpg")
        
        let customHeaderView = CustomHeaderView(subView: imageView, maxContentOff: -120, headerViewSize: CGSize(width: self.view.bounds.size.width,height: 100),delegate:self)
        tableView.tableHeaderView = customHeaderView

    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.delegate = self;
    }



    override func viewWillDisappear(animated: Bool)
    {
        tableView.delegate = nil
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.relieveCover()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - UIScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView){
        
        //获得当前的自定义HeaderView对象
        let customView:CustomHeaderView = (scrollView as! UITableView).tableHeaderView as! CustomHeaderView
        
        //设置滚动
        customView.layoutHeaderWillScroll(scrollView.contentOffset)
        
    }

    
    @IBAction func nextBarTap(sender: AnyObject)
    {
        let testController = UIViewController()
        testController.navigationItem.title = "Test"
        testController.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.pushViewController(testController, animated: true)
    }
    
    
    
    //MAKR: - UITableView DataScource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Test" + String(indexPath.row)
        
        return cell
    }
    
    
    //MARK: -UITableView Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    
    //MARK: - CustomHeaderViewDelegate
    func customHeaderView(customHeaderView: CustomHeaderView, lockScrollView maxContentOffSet: CGFloat) {
       
        //锁定滚动视图
        self.tableView.contentOffset.y = maxContentOffSet
    }

    func customHeaderView(customHeaderView: CustomHeaderView, shouldChangeBarAlpha alpha:CGFloat) {
      
        //设置透明度
        self.navigationController?.navigationBar.setViewColor(self.barColor.colorWithAlphaComponent(alpha))
    }
}

