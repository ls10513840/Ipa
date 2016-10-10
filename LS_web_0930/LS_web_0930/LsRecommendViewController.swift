//
//  LsRecommendViewController.swift
//  LS_web_0930
//
//  Created by 千锋 on 16/9/30.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class LsRecommendViewController: UIViewController {
    var pageCtrl:UIPageControl?
      override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        let label = UILabel(frame:CGRectMake(0, 0, 300, 44) )
        label.text = "精品栏目推荐"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(25)
        label.textColor = UIColor.whiteColor()
        navigationItem.titleView = label
        createLatticework()
    }
    func createLatticework(){
        self.automaticallyAdjustsScrollViewInsets = false
        let titles = ["每日一荐","本周热门应用","本周热门游戏","上榜精品","GameCenter游戏","装机必备","知名网站客户端","五星好评应用","随便看看","i派党移动版","苹果新闻","iphone4壁纸","用户交流QQ群","i派党移动微博"]
        let imageNames = ["i-commend","i-soft","i-game","i-top","i-gamecenter","i-musthave","i-famous","i-star","i-random","i-ipadown","i-news","i-download","i-qqgroup","i-sinaweibo"]
        let scrrollView = UIScrollView(frame: CGRectMake(0, 0, 414, 736-64-49))
        scrrollView.delegate = self
        scrrollView.showsHorizontalScrollIndicator = false
        
        let intervalW:CGFloat = 30
        let intervalH:CGFloat = 44
        
        for i in 0..<titles.count{
            let pageIndex = i/12
            let rowAndCol = i%12
            
            let row = rowAndCol/3
            let col = rowAndCol%3
            
            let title = titles[i]
            let imageName = imageNames[i]
            
            let frame = CGRectMake(25+CGFloat(pageIndex)*414+(intervalW+100)*CGFloat(col), 100-64+(intervalH+104)*CGFloat(row), 100, 104)
            let view = Myutil.creatView(frame, title: title, bgImageName: imageName, target: self, action: #selector(clickAction(_:)))
            view.tag = 300 + i
            scrrollView.addSubview(view)
        }
        var pageCnt = titles.count/12
        if (titles.count%12 > 0){
            pageCnt += 1
        }
        scrrollView.contentSize = CGSizeMake(414*CGFloat(pageCnt),scrrollView.bounds.size.height)
        scrrollView.pagingEnabled = true
        self.view.addSubview(scrrollView)
        
        pageCtrl = UIPageControl(frame: CGRectMake(0, 736-64-49-40, 414, 40))
        self.pageCtrl?.numberOfPages = pageCnt
        self.pageCtrl?.currentPageIndicatorTintColor = UIColor.blueColor()
        self.pageCtrl?.pageIndicatorTintColor = UIColor.grayColor()
        self.view.addSubview(pageCtrl!)
     }
    func clickAction(tap:UITapGestureRecognizer){
        let index = (tap.view?.tag)! - 300
        if index == 0{
            let edCtrl = EDViewController()
            navigationController?.pushViewController(edCtrl, animated: true)
        }else if index == 10{
            let webCtrl = WebbaseViewController()
            webCtrl.headtitle = "新闻"
            webCtrl.urlString = "http://i.ifeng.com"
            navigationController?.pushViewController(webCtrl, animated: true)
        }else if index == 11 {
            let webCtrl = WebbaseViewController()
            webCtrl.headtitle = "壁纸"
            webCtrl.urlString = "http://sj.zol.com.cn/bizhi/"
            navigationController?.pushViewController(webCtrl, animated: true)
        }else if index == 13{
            let webCtrl = WebbaseViewController()
            webCtrl.headtitle = "微博"
            webCtrl.urlString = "http://m.weibo.cn"
            navigationController?.pushViewController(webCtrl, animated: true)
        }else if index == 8{
            let webCtrl = WebbaseViewController()
            webCtrl.headtitle = "😄"
            webCtrl.urlString = "http://shouyou.gamersky.com/z/yys/"
            navigationController?.pushViewController(webCtrl, animated: true)
         
        }else{
            
        }
        
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
extension LsRecommendViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        pageCtrl?.currentPage = index
    }
}