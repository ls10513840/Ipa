//
//  LscategoryViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class LscategoryViewController: LsBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.text = "按分类筛选"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
        
    }
    override func downloadData() {
        let urlString = "http://api.ipadown.com/iphone-client/category.list.php"
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
extension LscategoryViewController:LsDownLoaderDelegate{
    func lsdownloader(downloader: LsDownLoader, didFailWithError error: NSError) {
        print(error.description)
    }
    func lsdownloader(downloader: LsDownLoader, didFinishWithData data: NSData) {
        do{
            let result = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            if result.isKindOfClass(NSArray.self){
                let array = result as! Array<Dictionary<String,AnyObject>>
                for dict in array{
                    let model = CatrgoryModel()
                    model.setValuesForKeysWithDictionary(dict)
                    let listArray = dict["list"] as! Array<Dictionary<String,AnyObject>>
                    let typeArray = NSMutableArray()
                    for typeDict in listArray{
                        let typeModel = CateType()
                        typeModel.setValuesForKeysWithDictionary(typeDict)
                        typeArray.addObject(typeModel)
                    }
                    model.typeArray = typeArray
                    self.dataArray.addObject(model)
                    
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
extension LscategoryViewController{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.dataArray[section] as! CatrgoryModel
        return (model.typeArray?.count)!
       
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "categoryCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CategoryCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CategoryCell", owner: nil, options: nil).last as? CategoryCell
        }
        let model = dataArray[indexPath.section] as! CatrgoryModel
        let type = model.typeArray![indexPath.row] as! CateType
        cell?.cofigCell(type)
        return cell!
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = self.dataArray[section] as! CatrgoryModel
        return model.header
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailCtl = DetailViewController()
        let model = dataArray[indexPath.section] as! CatrgoryModel
        let typeModel = model.typeArray![indexPath.row] as! CateType
        detailCtl.categoryId = typeModel.querystr
        detailCtl.categoryName = typeModel.title
        navigationController?.pushViewController(detailCtl, animated: true)
    }
    
}