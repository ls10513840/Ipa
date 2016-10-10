//
//  HPHeaderView.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/6.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class HPHeaderView: UIView {

    @IBOutlet weak var headScrollView: UIScrollView!
  
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pageCtl: UIPageControl!
    func downloadData(){
        
    }
    func loadScrollImages(model:LsScrollViewModel){
        let v = self.viewWithTag(100)
        self.bringSubviewToFront(v!)
        let imageView = UIImageView()
        let url = NSURL(string: model.pic!)
        imageView.kf_setImageWithURL(url!)
        headScrollView.addSubview(imageView)
        headScrollView.contentSize = CGSizeMake(CGFloat(4*414), 180)
        headScrollView.delegate = self
        pageCtl.numberOfPages = 4
        titleLabel.text = model.title
    }
}
extension HPHeaderView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x)/414
        
        pageCtl.currentPage = index
        
    }
}