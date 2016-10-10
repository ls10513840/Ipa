//
//  LsHPCell.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var sizeLabe: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    func configModel(model:LsHPModel,atIndex index:Int){
        let url = NSURL(string: model.app_icon!)
        headImageView.kf_setImageWithURL(url!)
        
          nameLabel.text = "\(index+1)."+model.post_title!
       
        if model.app_apple_rated != nil {
            starsLabel.text = "评分:\(model.app_apple_rated!)星"
        }
        if model.app_price == "0" {
            priceLabel.text = "免费中"
        }else{
            priceLabel.text = "\(model.app_price!)元"
        }
        categoryLabel.text = "类别：\(model.app_category!)"
        sizeLabe.text = model.app_size!
        descLabel.text = model.app_desc!
        
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
