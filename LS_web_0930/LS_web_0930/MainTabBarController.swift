//
//  MainTabBarController.swift
//  1604LimitFree
//
//  Created by 千锋 on 16/9/26.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建子视图控制器
       lscreateViewControllers()
       
      
    }
    func lscreateViewControllers(){
        //title
        let titleArray = ["首页","今日限免","分类","推荐","更多"]
        let imageArray = ["item_app_home","item_app_pricedrop","item_app_category","item_app_hot","item_app_more"]
        let ctrlArray = ["LS_web_0930.LsHomePageViewController","LS_web_0930.LsLimitFreeViewController","LS_web_0930.LscategoryViewController","LS_web_0930.LsRecommendViewController","LS_web_0930.LsMoreViewController"]
        var array = Array<UINavigationController>()
        for i in 0..<titleArray.count{
            let ctrlName = ctrlArray[i]
            let cls = NSClassFromString(ctrlName) as!
            UIViewController.Type
            let ctrl = cls.init()
            
            ctrl.tabBarItem.title = titleArray[i]
            let imageName = imageArray[i]
            ctrl.tabBarItem.image = UIImage(named: imageName)!.imageWithRenderingMode(.AlwaysOriginal)
            
            let navCtrl = UINavigationController(rootViewController: ctrl)
            
            navCtrl.navigationBar.barStyle = .BlackTranslucent
            var bgImage = UIImage(named: "top-bg")

            bgImage = bgImage?.stretchableImageWithLeftCapWidth(0, topCapHeight: 0)
            navCtrl.navigationBar.setBackgroundImage(bgImage, forBarMetrics: .Default)
            array.append(navCtrl)
        }
        viewControllers = array
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
