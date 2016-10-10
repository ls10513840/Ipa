//
//  WebbaseViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/10/8.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class WebbaseViewController: UIViewController {
    var webView:UIWebView?
    var urlString:String?
    var headtitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.text = headtitle!
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
        creatNavBtn()
        createwebView()
        creatNavBtn()
    }
    func createwebView(){
        webView = UIWebView(frame: UIScreen.mainScreen().bounds)
        let url = NSURL(string: urlString!)
        let request = NSURLRequest(URL: url!)
        webView?.loadRequest(request)
        self.view.addSubview(webView!)
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
