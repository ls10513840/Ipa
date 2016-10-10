//
//  DetailViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/7.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class DetailViewController: LsBaseViewController{
    var categoryId:String?
    var categoryName:String?
    var rightBtn:UIButton?
    var index:Int = 0
    var segCtrl:UISegmentedControl?
    var siftView:UIView?
    var siftLabel:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createNavTitle()
        creatNavBtn()
        addHeader()
        addFooter()
    }
    func createNavTitle(){
        let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.center = self.view.center
        label.text = categoryName
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
    }
    func creatNavBtn(){
        let leftBtn = UIButton(type: .System)
        leftBtn.frame = CGRectMake(0, 0, 50, 30)
        leftBtn.setBackgroundImage(UIImage(named:"backButton")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        leftBtn.addTarget(self, action: #selector(backAction), forControlEvents: .TouchUpInside)
        leftBtn.setTitle("返回", forState: .Normal)
        leftBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        rightBtn = UIButton(type: .System)
        rightBtn!.frame = CGRectMake(0, 0, 50, 30)
        rightBtn!.setBackgroundImage(UIImage(named:"price-bg")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        rightBtn!.addTarget(self, action: #selector(siftAction), forControlEvents: .TouchUpInside)
        rightBtn!.setTitle("筛选", forState: .Normal)
        rightBtn!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:rightBtn!)
    }
    func backAction(){
        navigationController?.popViewControllerAnimated(true)
    }
    func siftAction(){
        if rightBtn?.currentTitle == "取消"{
            self.segCtrl?.removeFromSuperview()
            self.segCtrl = nil
            
            self.siftView?.removeFromSuperview()
            self.siftView = nil
            
            self.siftLabel?.removeFromSuperview()
            self.siftLabel = nil
            
            let title = self.segCtrl?.titleForSegmentAtIndex(self.index)
            self.rightBtn?.setTitle(title, forState: .Normal)
        }else{
            siftView = UIView(frame: CGRectMake(0, 0, 414, 736-49-64))
            siftView?.backgroundColor = UIColor.blackColor()
            siftView?.alpha = 0.7
            view.addSubview(siftView!)
            
            siftLabel = UILabel(frame: CGRectMake(414/2-150, 43, 300, 44))
            siftLabel?.textAlignment = .Left
            siftLabel?.text = "价格筛选:"
            siftLabel?.textColor = UIColor.whiteColor()
            siftLabel?.font = UIFont.systemFontOfSize(20)
            view.addSubview(siftLabel!)
            
            segCtrl = UISegmentedControl(items: ["全部","免费","限免","付费"])
            segCtrl?.frame = CGRectMake(414/2-150, 90, 300, 44)
            segCtrl?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: .Normal)
            segCtrl?.addTarget(self, action:#selector(selectAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
            self.segCtrl?.selectedSegmentIndex = self.index
            view.addSubview(segCtrl!)
            
            rightBtn?.setTitle("取消", forState: .Normal)
        }
    }
    func selectAction(segCtrl:UISegmentedControl){
        index = segCtrl.selectedSegmentIndex
        let title = segCtrl.titleForSegmentAtIndex(index)
        rightBtn?.setTitle(title, forState: .Normal)
        
        self.curPage = 1
        self.downloadData()
        self.tbView?.contentOffset = CGPointZero
        
        self.segCtrl?.removeFromSuperview()
        self.siftView?.removeFromSuperview()
    }
    override func downloadData() {
        var catePrice = ""
        if (self.index == 0) {
            catePrice = "all"
        }else if (self.index == 1){
            catePrice = "free"
        }else if (self.index == 2){
            catePrice = "pricedrop"
        }else if (self.index == 3){
            catePrice = "paid"
        }
        let urlString = String(format: "http://api.ipadown.com/iphone-client/apps.list.php?%@&count=20&page=%ld&device=iPhone&price=%@", categoryId!,curPage,catePrice)
        
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
extension DetailViewController:LsDownLoaderDelegate{
    func lsdownloader(downloader: LsDownLoader, didFailWithError error: NSError) {
        print(error.description)
    }
    func lsdownloader(downloader: LsDownLoader, didFinishWithData data: NSData) {
        if self.curPage == 1 {
            self.dataArray.removeAllObjects()
        }
        do{
          let result = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if result.isKindOfClass(NSArray.self){
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
        }catch let err as NSError{
            print(err.description)
        }
    }
}
extension DetailViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "DetailCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? DetailCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("DetailCell", owner: nil, options: nil).last as? DetailCell
        }
        let model = dataArray[indexPath.row] as! LsHPModel
        cell?.configModel(model, atIndex: indexPath.row)
        return cell!
    }
}