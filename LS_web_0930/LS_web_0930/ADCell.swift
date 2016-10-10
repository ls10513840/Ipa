//
//  ADCell.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/6.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class ADCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageCtl: UIPageControl!
    var dataArray:NSArray?{
        didSet{
            for i in 0..<(self.dataArray?.count)!{
                let model = self.dataArray![i] as! LsScrollViewModel
                let imageView = UIImageView(frame: CGRectMake(CGFloat(i)*414, 0, 414, 180))
                let url = NSURL(string: model.pic!)
                imageView.kf_setImageWithURL(url!, placeholderImage:UIImage(named: "placeholder-ad"))
                scrollView.addSubview(imageView)
            }
            self.scrollView.delegate = self
            self.scrollView.pagingEnabled = true
            self.scrollView.bounces = false
            self.scrollView.contentSize = CGSizeMake(CGFloat((dataArray?.count)!)*414, 160)
            titleLabel.text = (dataArray?.firstObject as! LsScrollViewModel).title
            self.pageCtl.numberOfPages = (self.dataArray?.count)!
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ADCell:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x/414)
            let modle = dataArray![index] as! LsScrollViewModel
            titleLabel.text = modle.title

        self.pageCtl.currentPage = index
    }
}