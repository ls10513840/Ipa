//
//  Myutil.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/8.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class Myutil: NSObject {
    class func creatBtn(frame:CGRect,title:String?,bgImageName:String?,target:AnyObject?,action:Selector)->UIButton{
        let btn = UIButton(type: .Custom)
        btn.frame = frame
        if title != nil {
            btn.setTitle(title, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if bgImageName != nil{
            btn.setImage(UIImage(named: bgImageName!), forState: .Normal)
        }
        if target != nil{
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
    class func creatLable(frame:CGRect,title:String?)->UILabel{
        let label = UILabel(frame: frame)
        if title != nil{
            label.text = title
        }
        return label
    }
    class func creatView(frame:CGRect,title:String?,bgImageName:String?,target:AnyObject?,action:Selector)->UIView{
        
        let view = UIView(frame: frame)
        //view.backgroundColor = UIColor.yellowColor()
        let imageView = UIImageView(frame: CGRectMake(10, 0, 80, 80))
        if bgImageName != nil{
           imageView.image = UIImage(named: bgImageName!)
        }
        view.addSubview(imageView)
        let label = UILabel(frame: CGRectMake(0, 80+4, 100, 20))
        if title != nil{
            label.text = title
            label.textAlignment = .Center
            label.textColor = UIColor.blackColor()
            label.font = UIFont.systemFontOfSize(12)
            label.adjustsFontSizeToFitWidth = true
        }
        view.addSubview(label)
        if target != nil{
           view.userInteractionEnabled = true
           let tap = UITapGestureRecognizer(target: target, action: action)
            view.addGestureRecognizer(tap)

        }
     
        return view
    }
}
