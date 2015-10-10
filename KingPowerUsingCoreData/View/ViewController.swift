//
//  ViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/23/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, sortDataDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var setupNav = KPNavigationBar()
    var productArray:[ProductModel] = []
    var database:FMDatabase!
    var popViewController : popupViewController!
    let detailTransitioningDelegate: PresentationManager = PresentationManager()
    var sortingIndex:Int = 0
    
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
        var sortDataArray:[String] = ["PRODUCT NAME A-Z","PRODUCT NAME Z-A","BRAND NAME A-Z","BRAND NAME Z-A","PRICE LOW-HIGHT","PRICE HIGHT-LOW","NEW ARRIVAL","MOST POPULAR","DISCOUNT"]
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav.setupNavigationBar(self)
        // Do any additional setup after loading the view, typically from a nib.
        //self.openDB()
        //self.query()
        productArray = ProductController().getProductByOrder("prod_id", sort: "ASC")
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        self.setupNavigationBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("viewcell",
            forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.productName.text = (self.productArray[indexPath.row]).prod_name
        cell.productDescription.text = (self.productArray[indexPath.row]).prod_description
        /*
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.currencyCode = "THB"
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.negativeFormat = "-¤#,##0.00"
        
        cell.productPrice.text = currencyFormatter.stringFromNumber(self.productArray[indexPath.row].product_price)
*/
        cell.productPrice.text = NSNumber(double: self.productArray[indexPath.row].prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
        cell.backgroundColor = UIColor.whiteColor()
        cell.productImage.image = UIImage(named: self.productArray[indexPath.row].prod_imageArray[0].proi_image_path)
        cell.productImage.layer.borderWidth = 1.0
        cell.productImage.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
        return cell
    }
    
    func backToPreviousPage(sender: AnyObject) {
        print("backtopreviouspage")
        self.navigationController?.popViewControllerAnimated(true)
    }

    func setSorting(sortIndex : Int){
        self.sortingIndex = sortIndex
        //["PRODUCT NAME A-Z","PRODUCT NAME Z-A","BRAND NAME A-Z","BRAND NAME Z-A","PRICE LOW-HIGHT","PRICE HIGHT-LOW","NEW ARRIVAL","MOST POPULAR","DISCOUNT"]
        if sortIndex == 0 {
            self.productArray = productArray.sort({ $0.prod_name < $1.prod_name })
            //self.productArray = ProductController().getProductByOrder("prod_name", sort: "ASC")
        }else if sortIndex == 1 {
            self.productArray = productArray.sort({ $0.prod_name > $1.prod_name })
            //self.productArray = ProductController().getProductByOrder("prod_name", sort: "DESC")
        }else if sortIndex == 2 {
           self.productArray = productArray.sort({ $0.prod_bran.bran_name < $1.prod_bran.bran_name })
        }else if sortIndex == 3 {
            self.productArray = productArray.sort({ $0.prod_bran.bran_name > $1.prod_bran.bran_name })
        }else if sortIndex == 4 {
            self.productArray = productArray.sort({ $0.prod_price > $1.prod_price })
        }else if sortIndex == 5 {
            self.productArray = productArray.sort({ $0.prod_price < $1.prod_price })
        }else if sortIndex == 6 {
            self.productArray = productArray.sort({ $0.prod_rating > $1.prod_rating })
        }else if sortIndex == 7 {
            self.productArray = productArray.sort({ $0.prod_rating > $1.prod_rating })
        }else if sortIndex == 8 {
            self.productArray = productArray.sort({ $0.prod_discount_price > $1.prod_discount_price })
            
        }
        
        /*
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDuration(0.5)
        
        self.collectionView.reloadData()
        UIView.commitAnimations()
        self.dismissViewControllerAnimated(true, completion: nil)
*/
        UIView.transitionWithView(collectionView,
            duration:0.2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations:
            { () -> Void in
                self.collectionView.reloadData()
            },
        completion: nil)
        //self.collectionView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
          if (segue.identifier == "segueDetail") {
            if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
              (segue.destinationViewController as! ProductDetailViewController).productDetail = productArray[indexPath.row]
            }
          }
          else if (segue.identifier == "popSegue") {
            let detailViewController = segue.destinationViewController as! popupViewController
            //detailViewController.transitioningDelegate = detailTransitioningDelegate
            //detailViewController.modalPresentationStyle = .Custom
            detailViewController.sortingIndex = self.sortingIndex
            detailViewController.segment = 0
            detailViewController.delegate = self
          }
          else if (segue.identifier == "filterpopSegue") {
            let detailViewController = segue.destinationViewController as! popupViewController
            //detailViewController.transitioningDelegate = detailTransitioningDelegate
            //detailViewController.modalPresentationStyle = .Custom
            detailViewController.sortingIndex = self.sortingIndex
            detailViewController.segment = 1
            detailViewController.delegate = self
        }
        
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
//
//    
//
//    func setupNavigationBar(){
//        print("navigation frame: \(navigationController!.navigationBar.frame.width) x \(navigationController!.navigationBar.frame.height)")
//        //Remove the shadow image altogether
//        for parent in self.navigationController!.navigationBar.subviews {
//            for childView in parent.subviews {
//                if(childView is UIImageView) {
//                    childView.removeFromSuperview()
//                }
//            }
//        }
//        //Container Layout
//        navBar.frame=CGRectMake(0, 0, navigationController!.navigationBar.frame.width, navigationController!.navigationBar.frame.height)
//        navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
//        self.view.addSubview(navBar)
//        self.view.sendSubviewToBack(navBar)
//        
//        //Navigation Bar
//        self.navigationController!.navigationBar.barTintColor =  UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
//        
//        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
//        let imageTitleView = UIImageView(frame: CGRect(
//            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
//            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
//            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
//            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
//        
//        imageTitleView.contentMode = .ScaleAspectFit
//        imageTitleView.image = imageTitleItem
//        self.navigationItem.titleView = imageTitleView
//        
//        self.addRightNavItemOnView()
//        self.addLeftNavItemOnView()
//        
//    }
//    func addLeftNavItemOnView()
//    {
//        //Back
//        let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
//        buttonMenu.frame = CGRectMake(
//            gv.getConfigValue("navigationItemBackImgPositionX") as! CGFloat,
//            gv.getConfigValue("navigationItemBackImgPositionY") as! CGFloat,
//            gv.getConfigValue("navigationItemBackImgWidth") as! CGFloat,
//            gv.getConfigValue("navigationItemBackImgHeight") as! CGFloat)
//
//        buttonMenu.setImage(UIImage(named: gv.getConfigValue("navigationItemBackImgName") as! String), forState: UIControlState.Normal)
//        buttonMenu.addTarget(self, action: "backToPreviousPage:", forControlEvents: UIControlEvents.TouchUpInside) //use thiss
//        let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
//        
//        //Flight
//        let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
//        buttonFlight.frame = CGRectMake(
//            gv.getConfigValue("navigationItemAirplainImgPositionX") as! CGFloat,
//            gv.getConfigValue("navigationItemAirplainImgPositionY") as! CGFloat,
//            gv.getConfigValue("navigationItemAirplainImgWidth") as! CGFloat,
//            gv.getConfigValue("navigationItemAirplainImgHeight") as! CGFloat)
//        buttonFlight.setImage(UIImage(named: gv.getConfigValue("navigationItemAirplainImgName") as! String), forState: UIControlState.Normal)
//        buttonFlight.addTarget(self, action: "navItemFlightClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
//        
//        
//        // add multiple right bar button items
//        self.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu,leftBarButtonItemFilght], animated: true)
//        // uncomment to add single right bar button item
//        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
//        
//    }
//    func addRightNavItemOnView()
//    {
//        //Call
//        let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
//        buttonCall.frame = CGRectMake(
//            gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
//            gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
//            gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
//            gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
//        
//        buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
//        buttonCall.addTarget(self, action: "navItemCallClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
//        
//        //Cart
//        let buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
//        buttonCart.frame = CGRectMake(
//            gv.getConfigValue("navigationItemCartImgPositionX") as! CGFloat,
//            gv.getConfigValue("navigationItemCartImgPositionY") as! CGFloat,
//            gv.getConfigValue("navigationItemCartImgWidth") as! CGFloat,
//            gv.getConfigValue("navigationItemCartImgHeight") as! CGFloat)
//        
//        buttonCart.setImage(UIImage(named: gv.getConfigValue("navigationItemCartImgName") as! String), forState: UIControlState.Normal)
//        buttonCart.addTarget(self, action: "navItemCartClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        let rightBarButtonItemCart = UIBarButtonItem(customView: buttonCart)
//        
//        //Search
//        let buttonSearch = UIButton(type: UIButtonType.Custom) as UIButton
//        buttonSearch.frame = CGRectMake(
//            gv.getConfigValue("navigationItemSearchImgPositionX") as! CGFloat,
//            gv.getConfigValue("navigationItemSearchImgPositionY") as! CGFloat,
//            gv.getConfigValue("navigationItemSearchImgWidth") as! CGFloat,
//            gv.getConfigValue("navigationItemSearchImgHeight") as! CGFloat)
//        buttonSearch.setImage(UIImage(named: gv.getConfigValue("navigationItemSearchImgName") as! String), forState: UIControlState.Normal)
//        buttonSearch.addTarget(self, action: "navItemSearchClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        let rightBarButtonItemSearch = UIBarButtonItem(customView: buttonSearch)
//        
//        
//        
//        // add multiple right bar button items
//        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSearch,rightBarButtonItemCart,rightBarButtonItemCall], animated: true)
//        
//        // uncomment to add single right bar button item
//        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
//    }
//    
//    //Navigation Bar
//    func navItemFlightClick(sender:UIButton!)
//    {
//        self.removeNavigateView()
//        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
//        flightViewController.showInView(self.view, animated: true)
//    }
//    
//    func navItemCallClick(sender:UIButton!)
//    {
//        self.removeNavigateView()
//        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
//        callAssistanceViewController.showInView(self.view, animated: true)
//        
//    }
//    
//    func navItemCartClick(sender:UIButton!)
//    {
//        print("navItemCartClick")
//        let cartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
//        self.navigationController?.pushViewController(cartViewController!, animated: true)
//        
//    }
//    
//    func navItemSearchClick(sender:UIButton!)
//    {
//        print("navItemSearchClick")
//        let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
//        let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
//        searchViewController?.modalPresentationStyle = modalStyle
//        self.presentViewController(searchViewController!, animated: true, completion: nil)
//    }
//    
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

