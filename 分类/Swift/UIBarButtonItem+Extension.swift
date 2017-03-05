//
//  UIBarButtonItem+Extension.swift
//  Weibo19
//
//  Created by whong7 on 16/8/31.
//  Copyright © 2016年 whong7. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    convenience init(imgName: String? = nil,title:String? = nil, target: Any?, action: Selector?){
      
        self.init()
        
        let button = UIButton()
        
        //添加点击事件
        if let sel = action
        {
            button.addTarget(target, action: sel, for: .touchUpInside)
        }
        
        if let img = imgName
        {
            //设置按钮的图标
            button.setImage(UIImage.init(named: img), for: .normal)
            button.setImage(UIImage.init(named: "\(img)_highlighted"), for: .highlighted)
            button.sizeToFit()
            
            //把当前按钮设置成当前item的customView
            self.customView = button

        }
        
        if let t = title
        {
            button.setTitle(t, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.darkGray
                , for: .normal)
            button.setTitleColor(UIColor.orange, for: UIControlState.highlighted)
        }
        
        button.sizeToFit()
        
        //把当前按钮设置成当前item的customView
        self.customView = button
        
    }
    
    
}
