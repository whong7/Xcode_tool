//
//  UIButton+Extension.swift
//  Weibo19
//
//  Created by whong7 on 16/9/1.
//  Copyright © 2016年 whong7. All rights reserved.
//

import UIKit


extension UIButton
{
    convenience init(textColor : UIColor, fontSize:CGFloat) {
        self.init()
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
    }
}
