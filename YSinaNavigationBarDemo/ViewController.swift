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
    
    let barColor = UIColor.orange
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //设置导航栏的属性
        self.navigationController?.navigationBar.setViewColor(barColor.withAlphaComponent(0.0))
        
        //设置列表属性
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        //设置显示图片的视图
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 100))
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "backGround.jpg")
        
        let customHeaderView = CustomHeaderView(subView: imageView, maxContentOff: -120, headerViewSize: CGSize(width: self.view.bounds.size.width,height: 100),delegate:self)
        tableView.tableHeaderView = customHeaderView

    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.delegate = self;
    }



    override func viewWillDisappear(_ animated: Bool)
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
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        //获得当前的自定义HeaderView对象
        let customView:CustomHeaderView = (scrollView as! UITableView).tableHeaderView as! CustomHeaderView
        
        //设置滚动
        customView.layoutHeaderWillScroll(scrollView.contentOffset)
        
    }

    
    @IBAction func nextBarTap(_ sender: AnyObject)
    {
        let testController = UIViewController()
        testController.navigationItem.title = "Test"
        testController.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(testController, animated: true)
    }
    
    
    
    //MAKR: - UITableView DataScource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Test" + String(indexPath.row)
        
        return cell
    }
    
    
    //MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    
    //MARK: - CustomHeaderViewDelegate
    func customHeaderView(_ customHeaderView: CustomHeaderView, lockScrollView maxContentOffSet: CGFloat) {
       
        //锁定滚动视图
        self.tableView.contentOffset.y = maxContentOffSet
    }

    func customHeaderView(_ customHeaderView: CustomHeaderView, shouldChangeBarAlpha alpha:CGFloat) {
      
        //设置透明度
        self.navigationController?.navigationBar.setViewColor(self.barColor.withAlphaComponent(alpha))
    }
}

