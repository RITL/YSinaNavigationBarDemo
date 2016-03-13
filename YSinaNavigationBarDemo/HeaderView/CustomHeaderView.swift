//
//  CustomHeaderView.swift
//  YSinaNavigationBarDemo
//
//  Created by YueWen on 16/3/11.
//  Copyright © 2016年 YueWen. All rights reserved.
//

import UIKit

protocol CustomHeaderViewDelegate : class
{
    
    /**
     滚动已经到达最大偏移量，需要锁定滚动视图
     
     :param: customHeaderView
     :param: maxContentOffSet 最大偏移量
     */
    @available(iOS 8.0,*)
    func customHeaderView(customHeaderView:CustomHeaderView,lockScrollView  maxContentOffSet:CGFloat)
    
    
    
    /**
     滚动过程中修改导航Bar的透明度
     
     :param: customHeaderView
     :param: alpha            透明度
     */
    @available(iOS 8.0,*)
    func customHeaderView(customHeaderView:CustomHeaderView,shouldChangeBarAlpha alpha:CGFloat)
}




class CustomHeaderView: UIView {
    
    /// 代理
    weak var delegate:CustomHeaderViewDelegate?

    ///底层控制ImageView缩放的View，后面通过更改它的frame属性来实现圆滑效果
    var contentView:UIView! = UIView()
    
    /// 存放外部传入的视图，即ImageView
    var subView:UIView
    
    /// 最大的下拉距离
    var maxContentOff:CGFloat
    
    /// 起点的纵坐标
    private let originY:CGFloat = -64
    

    init(subView:UIView,maxContentOff:CGFloat,headerViewSize: CGSize,delegate: CustomHeaderViewDelegate)
    {
        self.subView = subView//当前的imageView
        self.delegate = delegate
        self.maxContentOff = maxContentOff > 0 ? -maxContentOff : maxContentOff//因为向下滑动是负数，进行数字正负转换
        
        super.init(frame: CGRectMake(0, 0, headerViewSize.width, headerViewSize.height))
        
        //开始自动布局设置，意思是自动将subView的frame与superView相一致
        subView.autoresizingMask = [.FlexibleTopMargin,.FlexibleBottomMargin,.FlexibleLeftMargin,.FlexibleRightMargin,.FlexibleWidth,.FlexibleHeight]
        
        //此视图不显示越界的视图
        self.clipsToBounds = false
        self.contentView.frame = self.bounds
        self.contentView.addSubview(subView)
        
        //存放ImageView的视图需要显示越界的视图
        self.contentView.clipsToBounds = true
        self.addSubview(contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - 对外接口
    func layoutHeaderWillScroll(offSet:CGPoint)
    {
        //获取垂直偏移量
        let contentOffY = offSet.y
        
        //如果大于
        if(contentOffY < maxContentOff)
        {
            //锁定坐标
            self.delegate?.customHeaderView(self, lockScrollView: maxContentOff)
        }
        
        else if(contentOffY < 0)//如果小于0，表示headerView还显示在ScrollView中
        {
            var rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
            
            rect.origin.y += contentOffY ;
            rect.size.height -= contentOffY;
            self.contentView.frame = rect;
        }
        
        //64 + 当前的垂直偏移量
        let alpha = (-originY + contentOffY) / self.frame.size.height
        
        //设置透明度
        self.delegate?.customHeaderView(self, shouldChangeBarAlpha: alpha)
    }
    
    
    
    
}
