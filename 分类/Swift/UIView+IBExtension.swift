//
//  UIView+IBExtension.swift
//  Weibo19
//
//  Created by whong7 on 16/8/31.
//  Copyright © 2016年 whong7. All rights reserved.
//

import UIKit

extension UIView
{
    ///storyBoard View圆角
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
