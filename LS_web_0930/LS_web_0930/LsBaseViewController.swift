//
//  LsBaseViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class LsBaseViewController: UIViewController {
    var tbView :UITableView?
    lazy var dataArray = NSMutableArray()
    
    var curPage:Int = 1
    //lazy var imageArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        createTableView()
        
        downloadData()
    }
    func createTableView(){
        automaticallyAdjustsScrollViewInsets = false
        
        tbView = UITableView(frame: CGRectMake(0, 0, 414, 736-64-49), style: .Plain)
       
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        
    }
    func downloadData(){
        print("子类未实现\(#function)")
    }
//    func downloadImage(){
//        
//    }
    func addFooter(){
        
        if self.tbView?.footerView == nil {
            self.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(LsBaseViewController.loadNextPage))
        }
        
    }
    //下拉刷新
    func addHeader(){
        if self.tbView?.headerView == nil {
            self.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(LsBaseViewController.loadFirstPage))
        }
        
    }
    func refreshHeader(){
        
    }
    func loadFirstPage(){
        curPage = 1
        downloadData()
       
    }
    func loadNextPage(){
        curPage += 1
        refreshHeader()
        downloadData()
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
extension LsBaseViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("子类未实现\(#function)")
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("子类未实现\(#function)")
        return UITableViewCell()
    }
}