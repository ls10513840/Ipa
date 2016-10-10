//
//  LsLimitFreeViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class LsLimitFreeViewController: LsBaseViewController {
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addHeader()
        addFooter()
        
        createNav()
    }
    func createNav(){
        let imageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        imageView.image = UIImage(named: "i-random")?.imageWithRenderingMode(.AlwaysOriginal)
        imageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(reloadViewData))
        imageView.addGestureRecognizer(tap)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        //使用分段选择控件作为标题
        let items = ["今日限免","本周热门限免","热门限免总榜"] as [AnyObject]
        let segmented = UISegmentedControl(items: items)
     
        segmented.center = self.view.center
        segmented.backgroundColor = UIColor.cyanColor()
//        segmented.tintColorDidChange()
        segmented.tintColor = UIColor.whiteColor()
        segmented.setBackgroundImage(UIImage(named:"toolBar 2"), forState: .Normal, barMetrics: .Default)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(LsLimitFreeViewController.segmentAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.navigationItem.titleView = segmented
    }
    func segmentAction(sender: UISegmentedControl){
        self.index = sender.selectedSegmentIndex
        self.curPage = 1
        self.tbView?.contentOffset = CGPointZero
        self.downloadData()
     }
    func reloadViewData(){
        tbView?.reloadData()
    }
    override func downloadData() {
        var urlString = ""
        if self.index == 0{
             urlString = String(format: "http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&count=20&page=%ld", curPage)
        }else if self.index == 1 {
             urlString = String(format: "http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&subday=7&orderby=views&count=20&page=%ld", curPage)
        }else if self.index == 2{
             urlString = String(format: "http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&orderby=views&count=20&page=%ld", curPage)
        }
        let d = LsDownLoader()
        d.delegate = self
        d.lsDownloadWithURLString(urlString)
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
extension LsLimitFreeViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "lsLFCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LsLFCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("LsLFCell", owner: nil, options: nil).last as? LsLFCell
        }
        let model = dataArray[indexPath.row] as! LsHPModel
        cell?.configModel(model, atIndex: indexPath.row)
        return cell!

    }
}
extension LsLimitFreeViewController:LsDownLoaderDelegate{
    func lsdownloader(downloader: LsDownLoader, didFailWithError error: NSError) {
        print(error.description)
    }
    func lsdownloader(downloader: LsDownLoader, didFinishWithData data: NSData) {
        if curPage == 1{
            dataArray.removeAllObjects()
        }
        do{
            let result = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if result.isKindOfClass(NSArray){
                let array = result as! Array<Dictionary<String,AnyObject>>
                for dict in array{
                    let model = LsHPModel()
                    model.setValuesForKeysWithDictionary(dict)
                    dataArray.addObject(model)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tbView?.reloadData()
                    self.tbView?.headerView?.endRefreshing()
                    self.tbView?.footerView?.endRefreshing()
                })
            }
        } catch{
            
        }
    }
}