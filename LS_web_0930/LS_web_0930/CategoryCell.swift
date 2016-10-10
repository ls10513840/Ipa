//
//  CategoryCell.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/7.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    func cofigCell(modle:CateType){
        let url = NSURL(string: modle.icon!)
        headImageView.kf_setImageWithURL(url!)
        titleLabel.text = modle.title
        descLabel.text = modle.desc
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
