//
//  PromotionPopupViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/24/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class PromotionPopupViewController: UIViewController {
    var goodsNowList = [Goods]()
    var goodsLaterList = [Goods]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "checkoutSegue" {
           
            let navigationController:UINavigationController = segue.destinationViewController as! UINavigationController
            let viewController:CheckoutViewController = navigationController.topViewController as! CheckoutViewController
           // let viewController:CheckoutViewController = segue.destinationViewController as! CheckoutViewController
            viewController.goodsNowList = goodsNowList
            viewController.goodsLaterList = goodsLaterList
        }
    }
    

}
