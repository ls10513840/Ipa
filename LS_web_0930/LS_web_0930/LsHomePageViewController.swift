//
//  LsHomePageViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class LsHomePageViewController: LsBaseViewController,LsDownLoaderDelegate {
     lazy var imageArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       addFooter()
       addHeader()
       let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.text = "精品限时免费"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
        
        self.downloadImage()
    }
    
   
    func downloadImage(){
        let urlString = "http://api.ipadown.com/iphone-client/ad.flash.php?count=5&device=iphone"
        let d = LsDownLoader()
        d.delegate = self
        d.type = 2
        d.lsDownloadWithURLString(urlString)
    }
    override func downloadData() {
        let urlString = String(format: "http://api.ipadown.com/iphone-client/apps.list.php?t=index&count=20&page=%ld&device=iPhone&price=all", curPage)
        let d = LsDownLoader()
        d.delegate = self
        d.type = 1
        d.lsDownloadWithURLString(urlString)
    }
//    override func refreshHeader() {
//        self.downloadImage()
//       imageArray.removeAllObjects()
//    }
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

extension LsHomePageViewController{
    func lsdownloader(downloader: LsDownLoader, didFailWithError error: NSError) {
        print(error.description)
    }
    func lsdownloader(downloader: LsDownLoader, didFinishWithData data: NSData) {
        
        if downloader.type == 1 {
            if self.curPage == 1{
                self.dataArray.removeAllObjects()
            }
            do {
                if self.curPage == 1{
                    self.dataArray.removeAllObjects()
                }
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
                
            } catch {
                
            }

        }else if downloader.type == 2{
            
                let result = try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                if result.isKindOfClass(NSArray.self){
                    let array = result as! Array<Dictionary<String,AnyObject>>
                    for dict in array{
                        let model = LsScrollViewModel()
                        model.setValuesForKeysWithDictionary(dict)
                        imageArray.addObject(model)
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tbView?.reloadData()
                        self.tbView?.headerView?.endRefreshing()
                        self.tbView?.footerView?.endRefreshing()
                    })
                }
            
          
        }
    }
}
extension LsHomePageViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = self.dataArray.count
        if self.imageArray.count > 0{
            num += 1
        }
        return num
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var h:CGFloat = 0
        if (self.imageArray.count > 0){
            if (indexPath.row == 0){
                h = 217
            }else{
                h = 100
            }
        }else{
            h = 100
        }
        return h
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.imageArray.count > 0){
            if indexPath.row == 0{
                let cellId = "ADCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ADCell
                if cell == nil{
                    cell = NSBundle.mainBundle().loadNibNamed("ADCell", owner: nil, options: nil).last as? ADCell
                }
                cell!.dataArray = self.imageArray
                return cell!
            }else{
                let cellId = "lsHPCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LsHPCell
                if cell == nil {
                    cell = NSBundle.mainBundle().loadNibNamed("LsHPCell", owner: nil, options: nil).last as? LsHPCell
                }
                let model = self.dataArray[indexPath.row-1] as! LsHPModel
                cell?.configModel(model, atIndex: indexPath.row-1,isHaveImage:true)
                return cell!
            }
            
        }else{
            let cellId = "lsHPCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LsHPCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("LsHPCell", owner: nil, options: nil).last as? LsHPCell
            }
            let model = self.dataArray[indexPath.row] as! LsHPModel
            cell?.configModel(model, atIndex: indexPath.row,isHaveImage:false)
            return cell!
        }
        
    }
    
}