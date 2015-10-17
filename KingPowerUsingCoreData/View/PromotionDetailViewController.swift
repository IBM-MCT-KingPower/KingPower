//
//  PromotionDetailViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/11/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class PromotionDetailViewController: UIViewController , UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableCategory: UITableView!
    @IBOutlet weak var relatedButton: UIButton!
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var relatedTableView: UITableView!
    @IBOutlet weak var promotionImage: UIImageView!
    @IBOutlet weak var promotionEffectiveDate: UILabel!
    @IBOutlet weak var promotionExpireDate: UILabel!
    var btnRelatedProduct = UIButton()
    var btnRecommendedProduct = UIButton()
    var isRelated = true
    
    var setupNav = KPNavigationBar()
    var selectedPromotion : PromotionModel = PromotionModel()
   
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    var commonViewController = CommonViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav.setupNavigationBar(self)
        // Do any additional setup after loading the view.
        
        
        
        print("SELECTED PROMOTION ID: \(selectedPromotion.prom_id)")
        print("SELECTED PROMOTION IMAGE COUNT : \(selectedPromotion.promotionImageArray.count)")
        print("IMAGE NAME: \(selectedPromotion.promotionImageArray[0].prmi_id) \(selectedPromotion.promotionImageArray[0].prmi_img_path)")
        
        var promotionImage : UIImage = UIImage(named: selectedPromotion.promotionImageArray[0].prmi_img_path)!
        
        
        
        self.promotionImage.image = promotionImage
        self.labelHeader.text = selectedPromotion.prom_name
        self.labelDetail.text = selectedPromotion.prom_content1+"\n\n"+selectedPromotion.prom_content2
        self.promotionEffectiveDate.text = commonViewController.castDateFromDate(selectedPromotion.prom_effective_date)
        self.promotionExpireDate.text = commonViewController.castDateFromDate(selectedPromotion.prom_expire_date)
        //Promotion
        // Set up the image you want to scroll & zoom and add it to the scroll view
        self.initialTabView()
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    func initialTabView(){
        let imgRelatedProduct = UIImage(named: "tab-Related1.png")
        btnRelatedProduct.frame = CGRectMake(0, 0, (imgRelatedProduct?.size.width)!/2, (imgRelatedProduct?.size.height)!/2)
        btnRelatedProduct.setImage(imgRelatedProduct, forState: .Normal)
        btnRelatedProduct.addTarget(self, action: "tappedRelated:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabView.addSubview(btnRelatedProduct)
        
        let imgRecommendedProduct = UIImage(named: "tab-Recommend0.png")
        
        btnRecommendedProduct.frame = CGRectMake((imgRelatedProduct?.size.width)!/2, 0, (imgRecommendedProduct?.size.width)!/2, (imgRecommendedProduct?.size.height)!/2)
        btnRecommendedProduct.setImage(imgRecommendedProduct, forState: .Normal)
        btnRecommendedProduct.addTarget(self, action: "tappedRecommended:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabView.addSubview(btnRecommendedProduct)
        
    }
    
    func tappedRelated(sender:UIButton!){
        print("tab related product")
        btnRelatedProduct.setImage(UIImage(named: "tab-Related1.png"), forState: UIControlState.Normal)
        btnRecommendedProduct.setImage(UIImage(named: "tab-Recommend0.png"), forState: UIControlState.Normal)
        self.isRelated = true
        self.relatedTableView.reloadData()
    }
    
    func tappedRecommended(sender:UIButton!){
        print("tab recommended product")
        btnRelatedProduct.setImage(UIImage(named: "tab-Related0.png"), forState: UIControlState.Normal)
        btnRecommendedProduct.setImage(UIImage(named: "tab-Recommend1.png"), forState: UIControlState.Normal)
        self.isRelated = false
        self.relatedTableView.reloadData()
    }

    
    // MARK: - TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CatagoryTableViewCell
        if isRelated {
            cell.clvRelated.hidden = false
            cell.clvRecommended.hidden = true
        } else {
            cell.clvRelated.hidden = true
            cell.clvRecommended.hidden = false
        }
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func viewFlightMethod(){
        self.removeNavigateView()
        CommonViewController().viewFlightMethod(self)
    }
    func callAssistMethod(){
        self.removeNavigateView()
        CommonViewController().callAssistMethod(self)
    }
    func searchMethod(){
        CommonViewController().searchMethod(self)
    }
    func viewCartMethod(){
        CommonViewController().viewCartMethod(self)
    }

    
    func removeNavigateView(){
        if(flightViewController != nil && !flightViewController.view.hidden)
        {
            flightViewController.view.removeFromSuperview()
        }
        if(callAssistanceViewController != nil && !callAssistanceViewController.view.hidden)
        {
            callAssistanceViewController.view.removeFromSuperview()
        }
    }

    
}