//
//  EDViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/8.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class EDViewController: LsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.text = "每日一荐"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
        creatNavBtn()
        addHeader()
        addFooter()
    }
    func creatNavBtn(){
        let leftBtn = UIButton(type: .System)
        leftBtn.frame = CGRectMake(0, 0, 50, 30)
        leftBtn.setBackgroundImage(UIImage(named:"backButton")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        
        leftBtn.addTarget(self, action: #selector(backAction), forControlEvents: .TouchUpInside)
        leftBtn.setTitle("返回", forState: .Normal)
        leftBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
       
    }
    func backAction(){
        navigationController?.popViewControllerAnimated(true)
    }
    override func downloadData() {
        let urlString = String(format: "http://api.ipadown.com/iphone-client/apps.list.php?t=commend&count=20&page=%ld&device=iPhone&price=all", curPage)
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
extension EDViewController:LsDownLoaderDelegate{
    func lsdownloader(downloader: LsDownLoader, didFailWithError error: NSError) {
        print(error.description)
    }
    func lsdownloader(downloader: LsDownLoader, didFinishWithData data: NSData) {
        if self.curPage == 1{
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
            
        }catch{
            
        }
    }
}
extension EDViewController{
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