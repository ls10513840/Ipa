//
//  LsMoreViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
public let kImageArray = "iamgeArray"
public let kTitleArray = "titleArray"
public let kSubtileArray = "subtitleArray"
class LsMoreViewController: UIViewController {
    var tbView:UITableView?
    lazy var dataArray = NSMutableArray()
    var titleArray:NSArray?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.text = "更多"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
        view.backgroundColor = UIColor.whiteColor()
        titleArray = ["更多栏目","客户端设置","关于客户端","关于i派党","我们的iOS移动客户端","我们的电脑客户端"]
        createDataArray()
        createTableView()
    }
    func createDataArray(){
        var dict1 = [String:AnyObject]()
        dict1[kImageArray] = ["c-top","c-zt","c-guide","c-jc"]
        dict1[kTitleArray] = ["排行标题","应用专题","精品导购","苹果学院"]
        dict1[kSubtileArray] = ["Appstroe各国实时排行榜","归类推荐精品软件游戏","精品应用程序导购指南","iPhone小技巧一网打尽"]
        dataArray.addObject(dict1)
        
        var dict2 = [String:AnyObject]()
        dict2[kTitleArray] = ["我收藏的Apps","清空本地缓存","开启或关闭推送"]
        dict2[kSubtileArray] = ["","一键清空","设置"]
        dataArray.addObject(dict2)
        
        var dict3 = [String:AnyObject]()
        dict3[kTitleArray] = ["软件名称","软件作者","意见反馈","技术支持","去AppStore给我们评价"]
        dict3[kSubtileArray] = ["精品显示免费","呵呵姑娘","ieliwb@gmail.com","www.ipadown.com",""]
        dataArray.addObject(dict3)
        
        var dict4 = [String:AnyObject]()
        dict4[kTitleArray] = ["关于ipai党","团队联系方式","App玩家交流QQ群"]
        dataArray.addObject(dict4)
        
        var dict5 = [String:AnyObject]()
        dict5[kTitleArray] = ["《精品限时免费》 for iPad","《苹果i新闻》for iPhone"]
        dataArray.addObject(dict5)
        
        var dict6 = [String:AnyObject]()
        dict6[kTitleArray] = ["i派党Mac客户端","ipai党AIR客户端"]
        dataArray.addObject(dict6)
    }
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectMake(0, 0, 414, 736-64-49), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        
        let headView = UIImageView(image: UIImage(named:"logo_empty"))
        headView.frame = CGRectMake(0, 0, 414, 90)
        tbView?.tableHeaderView = headView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LsMoreViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dict = dataArray[section] as! [String:AnyObject]
        let titleArray = dict[kTitleArray] as! [String]
        return titleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        var style:UITableViewCellStyle = .Subtitle
        if (indexPath.section == 1 || indexPath.section == 2){
            style = .Value1
        }
        if cell == nil{
            cell = UITableViewCell(style: style, reuseIdentifier: cellId)
        }
        let dict = dataArray[indexPath.section] as! [String:AnyObject]
        let titleArray = dict[kTitleArray] as! [String]
        cell?.textLabel?.text = titleArray[indexPath.row]
        if dict.keys.contains(kImageArray){
            let imageArray = dict[kImageArray] as! [String]
            let imageName = imageArray[indexPath.row]
            cell?.imageView?.image = UIImage(named: imageName)
        }else{
            cell?.imageView?.image = nil
        }
        if dict.keys.contains(kSubtileArray){
            let subtitleArray = dict[kSubtileArray] as! [String]
            let subtitle = subtitleArray[indexPath.row]
            cell?.detailTextLabel?.text = subtitle
        }else{
            cell?.detailTextLabel?.text = nil
        }
        cell?.accessoryType = .DisclosureIndicator
        return cell!
    }
}