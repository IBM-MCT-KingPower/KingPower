//
//  ViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/23/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, sortDelegate, sendSortFilterDelegate, searchDelegate {
    @IBOutlet weak var lblSearchResults:UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var setupNav = KPNavigationBar()
    var tempProductArray:[ProductModel] = []
    var productArray:[ProductModel] = []
    var database:FMDatabase!
    var popViewController : popupViewController!
    let detailTransitioningDelegate: PresentationManager = PresentationManager()
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    // Sort : Full List
    var sortDataArray:[String] = KPVariable.sortDataArray
    // Sort : Selected Index
    var sortingIndex:Int = 0
    var groupId:Int32 = 0
    
    // Filter : Full List
    var filterDetailSubCat:[ProductCategoryModel] = [] // select 1 subcat
    var filterDetailBrand:[BrandModel] = []             // select more than 1
    var filterDetailGender:[String] = KPVariable.genderList //Select 1 gender
    var filterDetailPriceRange:[String] = KPVariable.priceRangeList   // select 1 range
    var filterDetailColor:[String] = KPVariable.colorList             // Select more than 1
    // Filter : Selected Index/List
    var filterSubCatIndex:Int = -1
    var filterBrandIndex:NSMutableArray = NSMutableArray()
    var filterGenderIndex:Int = -1
    var filterPriceRangeIndex:Int = -1
    var filterColorIndex:NSMutableArray = NSMutableArray()
    
    // Search
    var searchResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav.setupNavigationBar(self)
        tempProductArray.appendContentsOf(productArray)
        if searchResult.characters.count == 0 {
            self.lblSearchResults.text = ""
        }else{
            self.lblSearchResults.text = searchResult
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setupNav.setAmountInCart()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
          if (segue.identifier == "segueDetail") {
            if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
              (segue.destinationViewController as! ProductDetailViewController).productDetail = productArray[indexPath.row]
            }
          }
          else if (segue.identifier == "popSegue") {
            let detailViewController = segue.destinationViewController as! popupViewController
            detailTransitioningDelegate.height = 450
            detailTransitioningDelegate.width = 600
            detailViewController.transitioningDelegate = detailTransitioningDelegate
            detailViewController.modalPresentationStyle = .Custom
            detailViewController.sortingIndex = self.sortingIndex
            detailViewController.filterSubCatIndex = filterSubCatIndex
            detailViewController.filterBrandIndex = filterBrandIndex
            detailViewController.filterGenderIndex = filterGenderIndex
            detailViewController.filterPriceRangeIndex = filterPriceRangeIndex
            detailViewController.filterColorIndex = filterColorIndex
            
            self.filterDetailBrand = BrandController().getAllBrand()
            if groupId == 0 {
                // self.filterDetailBrand = BrandController().getAllBrand()
                self.filterDetailSubCat = ProductMainCategoryController().getAllProductMainCategory()
            }else {
                //self.filterDetailBrand = BrandController().getBrandByGroupId(groupId)
                self.filterDetailSubCat = ProductMainCategoryController().getProductMainCategoryByProductGroupId(groupId)
            }
            detailViewController.filterDetailBrand = filterDetailBrand
            detailViewController.filterDetailSubCat = filterDetailSubCat
            detailViewController.segment = 0
            detailViewController.delegate = self
          }
          else if (segue.identifier == "filterpopSegue") {
            let detailViewController = segue.destinationViewController as! popupViewController
            detailTransitioningDelegate.height = 450
            detailTransitioningDelegate.width = 600
            detailViewController.transitioningDelegate = detailTransitioningDelegate
            detailViewController.modalPresentationStyle = .Custom
            detailViewController.sortingIndex = self.sortingIndex
            detailViewController.filterSubCatIndex = filterSubCatIndex
            detailViewController.filterBrandIndex = filterBrandIndex
            detailViewController.filterGenderIndex = filterGenderIndex
            detailViewController.filterPriceRangeIndex = filterPriceRangeIndex
            detailViewController.filterColorIndex = filterColorIndex
            
            self.filterDetailBrand = BrandController().getAllBrand()
            if groupId == 0 {
               // self.filterDetailBrand = BrandController().getAllBrand()
                self.filterDetailSubCat = ProductMainCategoryController().getAllProductMainCategory()
            }else {
                //self.filterDetailBrand = BrandController().getBrandByGroupId(groupId)
                self.filterDetailSubCat = ProductMainCategoryController().getProductMainCategoryByProductGroupId(groupId)
            }
            detailViewController.filterDetailBrand = filterDetailBrand
            detailViewController.filterDetailSubCat = filterDetailSubCat
            detailViewController.segment = 1
            detailViewController.delegate = self
        }
        
    }
    
    func viewFlightMethod(){
        self.removeNavigateView()
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        CommonViewController().viewFlightMethod(self, flight: flightViewController)
    }
    func callAssistMethod(){
        self.removeNavigateView()
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        CommonViewController().callAssistMethod(self, call: callAssistanceViewController)
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
    
    func setSorting(sortIndex : Int){
        self.sortingIndex = sortIndex
        print("SORTING INDEX \(sortingIndex)")
        //["PRODUCT NAME A-Z","PRODUCT NAME Z-A","BRAND NAME A-Z","BRAND NAME Z-A","PRICE LOW-HIGHT","PRICE HIGHT-LOW","NEW ARRIVAL","MOST POPULAR","DISCOUNT"]
        if sortIndex == 0 {
            self.productArray = productArray.sort({ $0.prod_name < $1.prod_name })
        }else if sortIndex == 1 {
            self.productArray = productArray.sort({ $0.prod_name > $1.prod_name })
        }else if sortIndex == 2 {
            self.productArray = productArray.sort({ $0.prod_bran.bran_name < $1.prod_bran.bran_name })
        }else if sortIndex == 3 {
            self.productArray = productArray.sort({ $0.prod_bran.bran_name > $1.prod_bran.bran_name })
        }else if sortIndex == 4 {
            self.productArray = productArray.sort({ $0.prod_price < $1.prod_price })
        }else if sortIndex == 5 {
            self.productArray = productArray.sort({ $0.prod_price > $1.prod_price })
        }else if sortIndex == 6 {
            self.productArray = productArray.sort({ $0.prod_arrival_flag > $1.prod_arrival_flag })
        }else if sortIndex == 7 {
            self.productArray = productArray.sort({ $0.prod_rating > $1.prod_rating })
        }else if sortIndex == 8 {
            self.productArray = productArray.sort({ $0.prod_discount_price > $1.prod_discount_price })
            
        }
        
        self.reloadWithAnimate()
    }
    
    func sendAllFilter(prodcatIndex: Int, brandIndexList: NSMutableArray, genderIndex: Int, priceRangeIndex: Int, colorIndexList: NSMutableArray) {
        self.productArray.removeAll()
        self.productArray.appendContentsOf(tempProductArray)
        // Filter
        if prodcatIndex != -1 {
            self.productArray = productArray.filter({ $0.prod_prc_id == filterDetailSubCat[prodcatIndex].prc_id })
        }
        if brandIndexList.count > 0 {
            var i : Int = 1
            var ind : Int = 1
            var tmpProductArray1 = productArray.filter({$0.prod_bran_id == filterDetailBrand[brandIndexList[0] as! Int].bran_id
            })
            var tmpProductArray2:[ProductModel] = []
            for (i=1 ; i < brandIndexList.count ; i++) {
                ind = brandIndexList[i] as! Int
                tmpProductArray2 = self.productArray.filter({$0.prod_bran_id == filterDetailBrand[ind].bran_id})
                tmpProductArray1.appendContentsOf(tmpProductArray2)
            }
            self.productArray = tmpProductArray1
        }
        if genderIndex != -1 {
            self.productArray = productArray.filter({ $0.prod_gender ==  filterDetailGender[genderIndex].uppercaseString })
            
        }
        if priceRangeIndex != -1 {
            //static var priceRangeList = ["< 2,000 THB", "2,000 - 5,000 THB", "5,000 - 10,000 THB", "10,000 - 15,000 THB", "15000 - 20000 THB", "> 20,000 THB"]
            if priceRangeIndex == 0 {
                self.productArray = productArray.filter({ $0.prod_price < 2000 })
            }else if priceRangeIndex == 1 {
                self.productArray = productArray.filter({ $0.prod_price >= 2000 && $0.prod_price < 5000 })
            }else if priceRangeIndex == 2 {
                self.productArray = productArray.filter({ $0.prod_price >= 5000 && $0.prod_price < 10000 })
            }else if priceRangeIndex == 3 {
                self.productArray = productArray.filter({ $0.prod_price >= 10000 && $0.prod_price < 15000 })
            }else if priceRangeIndex == 4 {
                self.productArray = productArray.filter({ $0.prod_price >= 15000 && $0.prod_price < 20000 })
            }else if priceRangeIndex == 5 {
                self.productArray = productArray.filter({ $0.prod_price >= 20000 })
            }
        }
        if colorIndexList.count != 0 {
            var i : Int = 1
            var ind : Int = 1
            var tmpProductArray1 = productArray.filter({ $0.prod_color == filterDetailColor[0] })
            var tmpProductArray2:[ProductModel] = []
            for (i=1 ; i < colorIndexList.count ; i++) {
                ind = colorIndexList[i] as! Int
                tmpProductArray2 = self.productArray.filter({$0.prod_color == filterDetailColor[ind]})
                tmpProductArray1.appendContentsOf(tmpProductArray2)
            }
            self.productArray = tmpProductArray1
        }
        // Keep to temp
        filterSubCatIndex = prodcatIndex
        filterBrandIndex = brandIndexList
        filterGenderIndex = genderIndex
        filterPriceRangeIndex = priceRangeIndex
        filterColorIndex = colorIndexList
        reloadWithAnimate()
    }
    
    func reloadWithAnimate(){
        UIView.transitionWithView(collectionView,
            duration:0.2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations:
            { () -> Void in
                self.collectionView.reloadData()
            },
            completion: nil)
        self.lblSearchResults.text = ""
    }
    
    func sendProductList(productArray: [ProductModel]) {
        self.tempProductArray.removeAll()
        self.tempProductArray.appendContentsOf(productArray)
        self.productArray = productArray
        self.reloadWithAnimate()
        self.lblSearchResults.text = "Found  \(productArray.count)  items"
    }
}

