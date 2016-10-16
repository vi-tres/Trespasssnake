//
//  MainViewController.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/11.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        self.view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(MainViewController.hideAd(_:)), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view.
    }

    func hideAd(_ sender:AnyObject){
        
        self.bannerView.isHidden = true
        self.closeButton.isHidden = true
        // or do
        self.closeButton.removeFromSuperview()
        self.bannerView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
