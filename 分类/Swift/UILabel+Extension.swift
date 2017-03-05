//
//  UILabel+Extension.swift
//  Weibo19
//
//  Created by whong7 on 16/9/1.
//  Copyright © 2016年 whong7. All rights reserved.
//

import UIKit

extension UILabel
{
    convenience init(textColor : UIColor, fontSize:CGFloat) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}
