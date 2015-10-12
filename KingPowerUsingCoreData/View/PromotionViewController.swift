//
//  PromotionViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/7/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import DynamicColor

class PromotionViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var setupNav = KPNavigationBar()
    
    @IBOutlet weak var scvPromotion: UIScrollView!
    @IBOutlet weak var pcPromotion: UIPageControl!
    @IBOutlet weak var vCatagory: UIView!
    @IBOutlet weak var tbvCatagory: UITableView!
    var navBar:UINavigationBar=UINavigationBar()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    //Promotion
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    //
    var btnRecommend = UIButton()
    var btnFasion = UIButton()
    var gv = GlobalVariable()
    var buttonList: [UIButton] = []
    var buttonName = ["Recommend","Fashion","Beauty","Electronics","Food","Liquor"]
    var Recommend = [""]
    //var arrContainer = [[String]]()
    // var arrays = [String]()
    var arrayIndex=0;
    var pointNow: CGPoint!
    var lastDirection:String!
    var productArray:[ProductModel] = []
    var prodRemain:Int = 0
    var prodRow:Int = 0
    var prodCount:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav.setupNavigationBar(self)
        self.getProductList(0)
        // Do any additional setup after loading the view.
        print("view.bounds: \(view.bounds.width) x \(view.bounds.height)")
        print("view.frame : \(view.frame.size.width) x \(view.frame.size.height)")
        scvPromotion.frame.origin.x = 0
        scvPromotion.frame.origin.y = 80
        scvPromotion.frame.size.height = 270
        print("scvPromotion.frame: \(scvPromotion.frame)")
        
        
        //Get Promotion Image
        var promotionController : PromotionController = PromotionController()
        var promotionArray : [PromotionModel] = promotionController.getPromotionAllEffective()
        
        let promotionCount = promotionArray.count
        var pageCount = 0
        
        print("No. of Promotion \(promotionArray.count)")
        if(promotionCount > 0){
            pageImages = []
            for i in 0...(promotionCount-1) {
               
                if(promotionArray[i].promotionImageArray.count > 0){
                    pageImages.append(UIImage(named:promotionArray[i].promotionImageArray[0].prmi_img_path)!)
                    pageCount = pageCount+1
                }
            }
        }else{
            //No Promotion Image
            //Need to set promotion default image
        }
        
        // Set up the page control
        pcPromotion.currentPage = 0
        pcPromotion.numberOfPages = pageCount
        pcPromotion.backgroundColor = UIColor(white: 1, alpha: 0)
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scvPromotion.frame.size
        scvPromotion.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        // Load the initial set of pages that are on screen
        loadVisiblePages()
        //
        setupTable()
        self.tbvCatagory.delegate = self
    }
    func getProductList(selectedGroup:Int){
        print(selectedGroup)
        // get product list
        self.productArray.removeAll()
        if selectedGroup == 0 {
            self.productArray = ProductController().getProductByGender(String(gv.getConfigValue("genderWomen")))//.getAllProduct()
        } else {
            self.productArray = ProductController().getProductByProductGroupID(Int32(selectedGroup))
        }
        prodRemain = self.productArray.count%8
        prodRow = self.productArray.count/8 + 1
        prodCount = self.productArray.count
        print("Product Count : \(prodCount)")
        self.tbvCatagory.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        // self.setupNavigationBar()
        //setupNav.setupNavigationBar(self)
    }
    //Start - Promotion
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scvPromotion.frame.size.width
        let page = Int(floor((scvPromotion.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        //print("page \(page)")
        // Update the page control
        pcPromotion.currentPage = page
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        // Load pages in our range
        for var index = 0; index < pageImages.count; ++index{
            print("..... \(index)")
            loadPage(index)
        }
//        for var index = firstPage; index <= lastPage; ++index {
//            print("....... \(index)")
//            loadPage(index)
//        }
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
//        // Load an individual page, first checking if you've already loaded it
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
            print("HERE >> \(page)")
        } else {
            print(">>> \(page)")
            var frame = scvPromotion.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            //frame = CGRectInset(frame, 10.0, 0.0)
            let newPageView = UIImageView(image: pageImages[page])
            //newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            //
            let btnPromotion = UIButton()
            //btnPromotion.setImage(pageImages[page],forState: .Normal)
            btnPromotion.titleLabel!.text = String(page)
            btnPromotion.titleLabel?.hidden = true
            btnPromotion.addTarget(self, action: "btnPromotionTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            btnPromotion.frame = CGRectMake((frame.width * CGFloat(page)) , 0, frame.width, frame.height)
            //btnPromotion.frame = CGRectMake(0, 0, frame.width, frame.height)
            
            print("Add Target Button to page \(page)")
            scvPromotion.addSubview(btnPromotion)
            scvPromotion.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    func btnPromotionTapped(sender:UIButton!){
        /*
        let vc = Detail2ViewController(nibName: "Detail2ViewController", bundle: nil)
        vc.id = "aa"
        navigationController?.pushViewController(vc, animated: true)
        */
        
        print("BTN PromotionTapped")
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PromotionDetailViewController") as! PromotionDetailViewController
        //print("test = \(vc.id)")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let product = sender.view
//        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProductDetailViewController") as! ProductDetailViewController
//        vc.productDetail = productArray[(product!.tag)]
//        self.navigationController?.pushViewController(vc, animated: true)

    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        pointNow = scrollView.contentOffset;
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == scvPromotion {
            // Load the pages that are now on screen
            //scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, 0), animated: false )
            loadVisiblePages()
        } else if scrollView == self.tbvCatagory{
            if scrollView.contentOffset.y < pointNow.y && lastDirection != "Down" { //Down
                UIView.animateWithDuration(0.5, animations: {
                    print("Down")
                    self.vCatagory.frame.origin.y = 340
                    self.tbvCatagory.frame.origin.y = 399
                    self.tbvCatagory.frame.size.height = 369
                    self.lastDirection = "Down"
                });
            }else if scrollView.contentOffset.y > pointNow.y && lastDirection != "Up" { //Up
                UIView.animateWithDuration(0.5, animations: {
                    print("Up")
                    self.vCatagory.frame.origin.y = 0 + 64
                    self.tbvCatagory.frame.origin.y = 0 + 64 + 40
                    self.tbvCatagory.frame.size.height = 768 - 64
                    self.lastDirection = "Up"
                });
            }
        }
    }
    //End - Promotion
    //Start - Catagory
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodRow
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentify = "Cell1"
        arrayIndex = 0
        if (indexPath.row%3 == 0) {
            cellIdentify = "Cell1"
        }
        else if (indexPath.row%3 == 1) {
            cellIdentify = "Cell3"
        }
        else {
            cellIdentify = "Cell2"
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as! Productlayout1TableViewCell!
        cell.resetProductView()
        let rowIndex = indexPath.row*8
        let count = self.productArray.count
        var curIndex = rowIndex + arrayIndex
        /*
        let gesture1 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v1.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v2.addGestureRecognizer(gesture2)
        
        let gesture3 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v3.addGestureRecognizer(gesture3)
        
        let gesture4 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v4.addGestureRecognizer(gesture4)
        
        let gesture5 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v5.addGestureRecognizer(gesture5)
        
        let gesture6 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v6.addGestureRecognizer(gesture6)
        
        let gesture7 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v7.addGestureRecognizer(gesture7)
        
        let gesture8 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
        cell.v8.addGestureRecognizer(gesture8)*/
        print(curIndex)
        if curIndex < count {
            cell.v1.hidden = false
            let product1 = self.productArray[curIndex]
            print("Product Name : \(product1.prod_name)")
            let gesture1 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v1.tag = curIndex
            cell.v1.addGestureRecognizer(gesture1)
            cell.v1_border.layer.borderWidth = 1
            cell.v1_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img1Product.image = UIImage(named: product1.prod_imageArray[0].proi_image_path)
            cell.img1Product.contentMode = .ScaleAspectFit
            cell.txtv1ProdName.text = product1.prod_name
            cell.txtv1ProdName.font = UIFont(name: "Century Gothic", size: 12)//?.bold
            cell.txtv1ProdName.textAlignment = .Center
            cell.lbl1ProdPrice.text = NSDecimalNumber(double: product1.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product1.prod_rating > 3 {
                cell.img1Tag.image = UIImage(named: "Best-Seller.png")
                cell.img1Tag.contentMode = .ScaleAspectFit
            }
            if product1.prod_flight_only == "Y" {
                cell.img1Plan.image = UIImage(named: "Flight_Only.png")
                cell.img1Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            print("\(curIndex)")
            //cell.v1.hidden = true
        }
        print(curIndex)
        if curIndex < count {
            cell.v2.hidden = false
            let product2 = self.productArray[curIndex]
            print("Product Name : \(product2.prod_name)")
            let gesture2 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v2.tag = curIndex
            cell.v2.addGestureRecognizer(gesture2)
            cell.v2_border.layer.borderWidth = 1
            cell.v2_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img2Product.image = UIImage(named: product2.prod_imageArray[0].proi_image_path)
            cell.img2Product.contentMode = .ScaleAspectFit
            cell.txtv2ProdName.text = product2.prod_name
            cell.txtv2ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv2ProdName.textAlignment = .Center
            cell.lbl2ProdPrice.text = NSDecimalNumber(double:product2.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product2.prod_rating > 3 {
                cell.img2Tag.image = UIImage(named: "Best-Seller.png")
                cell.img2Tag.contentMode = .ScaleAspectFit
            }
            if product2.prod_flight_only == "Y" {
                cell.img2Plan.image = UIImage(named: "Flight_Only.png")
                cell.img2Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            print("\(curIndex)")
            //cell.v2.hidden = true
        }
        print(curIndex)
        if curIndex < count {
            cell.v3.hidden = false
            let product3 = self.productArray[curIndex]
            print("Product Name : \(product3.prod_name)")
            let gesture3 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v3.tag = curIndex
            cell.v3.addGestureRecognizer(gesture3)
            cell.v3_border.layer.borderWidth = 1
            cell.v3_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img3Product.image = UIImage(named: product3.prod_imageArray[0].proi_image_path)
            cell.img3Product.contentMode = .ScaleAspectFit
            cell.txtv3ProdName.text = product3.prod_name
            cell.txtv3ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv3ProdName.textAlignment = .Center
            cell.lbl3ProdPrice.text = NSDecimalNumber(double: product3.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product3.prod_rating > 3 {
                cell.img3Tag.image = UIImage(named: "Best-Seller.png")
                cell.img3Tag.contentMode = .ScaleAspectFit
            }
            if product3.prod_flight_only == "Y" {
                cell.img3Plan.image = UIImage(named: "Flight_Only.png")
                cell.img3Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            print("\(curIndex)")
            //cell.v3.hidden = true
        }
        print(curIndex)
        if curIndex < count {
            cell.v4.hidden = false
            let product4 = self.productArray[curIndex]
            print("Product Name : \(product4.prod_name)")
            let gesture4 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v4.tag = curIndex
            cell.v4.addGestureRecognizer(gesture4)
            cell.v4_border.layer.borderWidth = 1
            cell.v4_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img4Product.image = UIImage(named: product4.prod_imageArray[0].proi_image_path)
            cell.img4Product.contentMode = .ScaleAspectFit
            cell.txtv4ProdName.text = product4.prod_name
            cell.txtv4ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv4ProdName.textAlignment = .Center
            cell.lbl4ProdPrice.text = NSDecimalNumber(double: product4.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product4.prod_rating > 3 {
                cell.img4Tag.image = UIImage(named: "Best-Seller.png")
                cell.img4Tag.contentMode = .ScaleAspectFit
            }
            if product4.prod_flight_only == "Y" {
                cell.img4Plan.image = UIImage(named: "Flight_Only.png")
                cell.img4Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            print("\(curIndex)")
            //cell.v4.hidden = true
        }
        print(curIndex)
        if curIndex < count {
            cell.v5.hidden = false
            let product5 = self.productArray[curIndex]
            print("Product Name : \(product5.prod_name)")
            let gesture5 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v5.tag = curIndex
            cell.v5.addGestureRecognizer(gesture5)
            cell.v5_border.layer.borderWidth = 1
            cell.v5_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img5Product.image = UIImage(named: product5.prod_imageArray[0].proi_image_path)
            cell.img5Product.contentMode = .ScaleAspectFit
            cell.txtv5ProdName.text = product5.prod_name
            cell.txtv5ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv5ProdName.textAlignment = .Center
            cell.lbl5ProdPrice.text = NSDecimalNumber(double: product5.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product5.prod_rating > 3 {
                cell.img5Tag.image = UIImage(named: "Best-Seller.png")
                cell.img5Tag.contentMode = .ScaleAspectFit
            }
            if product5.prod_flight_only == "Y" {
                cell.img5Plan.image = UIImage(named: "Flight_Only.png")
                cell.img5Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            //cell.v5.hidden = true
            print("\(curIndex)")
        }
        print(curIndex)
        if curIndex < count {
            cell.v6.hidden = false
            let product6 = self.productArray[curIndex]
            print("Product Name : \(product6.prod_name)")
            let gesture6 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v6.tag = curIndex
            cell.v6.addGestureRecognizer(gesture6)
            cell.v6_border.layer.borderWidth = 1
            cell.v6_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img6Product.image = UIImage(named: product6.prod_imageArray[0].proi_image_path)
            cell.img6Product.contentMode = .ScaleAspectFit
            cell.txtv6ProdName.text = product6.prod_name
            cell.txtv6ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv6ProdName.textAlignment = .Center
            cell.lbl6ProdPrice.text = NSDecimalNumber(double: product6.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product6.prod_rating > 3 {
                cell.img6Tag.image = UIImage(named: "Best-Seller.png")
                cell.img6Tag.contentMode = .ScaleAspectFit
            }
            if product6.prod_flight_only == "Y" {
                cell.img6Plan.image = UIImage(named: "Flight_Only.png")
                cell.img6Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            //cell.v6.hidden = true
            print("\(curIndex)")
        }
        print(curIndex)
        if curIndex < count {
            cell.v7.hidden = false
            let product7 = self.productArray[curIndex]
            print("Product Name : \(product7.prod_name)")
            let gesture7 = UITapGestureRecognizer(target: self, action: "tappedProduct:")
            cell.v7.tag = curIndex
            cell.v7.addGestureRecognizer(gesture7)
            cell.v7_border.layer.borderWidth = 1
            cell.v7_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img7Product.image = UIImage(named: product7.prod_imageArray[0].proi_image_path)
            cell.img7Product.contentMode = .ScaleAspectFit
            cell.txtv7ProdName.text = product7.prod_name
            cell.txtv7ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv7ProdName.textAlignment = .Center
            cell.lbl7ProdPrice.text = NSDecimalNumber(double: product7.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product7.prod_rating > 3 {
                cell.img7Tag.image = UIImage(named: "Best-Seller.png")
                cell.img7Tag.contentMode = .ScaleAspectFit
            }
            if product7.prod_flight_only == "Y" {
                cell.img7Plan.image = UIImage(named: "Flight_Only.png")
                cell.img7Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            //cell.v7.hidden = true
            print("\(curIndex)")
        }
        print(curIndex)
        if curIndex < count {
            cell.v8.hidden = false
            let product8 = self.productArray[curIndex]
            print("Product Name : \(product8.prod_name)")
            let gesture8 = UITapGestureRecognizer(target: self, action: Selector("tappedProduct:"))
            cell.v8.tag = curIndex
            cell.v8.addGestureRecognizer(gesture8)
            cell.v8_border.layer.borderWidth = 1
            cell.v8_border.layer.borderColor = UIColor(hexString: "7FB6E1").CGColor
            cell.img8Product.image = UIImage(named: product8.prod_imageArray[0].proi_image_path)
            cell.img8Product.contentMode = .ScaleAspectFit
            cell.txtv8ProdName.text = product8.prod_name
            cell.txtv8ProdName.font = UIFont(name: "Century Gothic", size: 12)
            cell.txtv8ProdName.textAlignment = .Center
            cell.lbl8ProdPrice.text = NSDecimalNumber(double: product8.prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            if product8.prod_rating > 3 {
                cell.img8Tag.image = UIImage(named: "Best-Seller.png")
                cell.img8Tag.contentMode = .ScaleAspectFit
            }
            if product8.prod_flight_only == "Y" {
                cell.img8Plan.image = UIImage(named: "Flight_Only.png")
                cell.img8Plan.contentMode = .ScaleAspectFit
            }
            arrayIndex++
            curIndex = rowIndex + arrayIndex
        }else{
            //cell.v8.hidden = true
            print("\(curIndex)")
        }
        return cell
    }
    func tappedProduct(sender:UITapGestureRecognizer){
        // do other task
        let product = sender.view
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProductDetailViewController") as! ProductDetailViewController
        vc.productDetail = self.productArray[(product!.tag)]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //End Catagory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Navigation Bar
    // func setupNavigationBar(){
    // print("navigation frame: \(navigationController!.navigationBar.frame.width) x \(navigationController!.navigationBar.frame.height)")
    // //Remove the shadow image altogether
    // for parent in self.navigationController!.navigationBar.subviews {
    // for childView in parent.subviews {
    // if(childView is UIImageView) {
    // childView.removeFromSuperview()
    // }
    // }
    // }
    // //Container Layout
    // navBar.frame=CGRectMake(0, 0, navigationController!.navigationBar.frame.width, navigationController!.navigationBar.frame.height)
    // navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
    // self.view.addSubview(navBar)
    // self.view.sendSubviewToBack(navBar)
    //
    // //Navigation Bar
    // self.navigationController!.navigationBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
    //
    // let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
    // let imageTitleView = UIImageView(frame: CGRect(
    // x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
    // y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
    // width: gv.getConfigValue("navigationBarImgWidth") as! Int,
    // height: gv.getConfigValue("navigationBarImgHeight") as! Int))
    //
    // imageTitleView.contentMode = .ScaleAspectFit
    // imageTitleView.image = imageTitleItem
    // self.navigationItem.titleView = imageTitleView
    //
    // self.addRightNavItemOnView()
    // self.addLeftNavItemOnView()
    //
    // }
    // func addLeftNavItemOnView()
    // {
    // //Menu
    // let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
    // buttonMenu.frame = CGRectMake(0, 0, 40, 40)
    // buttonMenu.setImage(UIImage(named:"Burger.png"), forState: UIControlState.Normal)
    // buttonMenu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside) //use this
    // let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
    //
    // if self.revealViewController() != nil {
    // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    // //btnMenu2.target = self.langRevealViewController()
    // //btnMenu2.action = "langRevealToggle:"
    // // Uncomment to change the width of menu
    // //self.revealViewController().rearViewRevealWidth = 62
    // }
    //
    // //Flight
    // let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
    // buttonFlight.frame = CGRectMake(0, 0, 36, 36)
    // buttonFlight.setImage(UIImage(named:"Flight-WH80x80.png"), forState: UIControlState.Normal)
    // buttonFlight.addTarget(self, action: "navItemFlightClick:", forControlEvents: UIControlEvents.TouchUpInside)
    // let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
    //
    //
    // // add multiple right bar button items
    // self.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu,leftBarButtonItemFilght], animated: true)
    // // uncomment to add single right bar button item
    // //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    //
    // }
    // func addRightNavItemOnView()
    // {
    // //Call
    // let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
    // buttonCall.frame = CGRectMake(
    // gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
    // gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
    // gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
    // gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
    //
    // buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
    // buttonCall.addTarget(self, action: "navItemCallClick:", forControlEvents: UIControlEvents.TouchUpInside)
    // let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
    //
    // //Cart
    // let buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
    // buttonCart.frame = CGRectMake(
    // gv.getConfigValue("navigationItemCartImgPositionX") as! CGFloat,
    // gv.getConfigValue("navigationItemCartImgPositionY") as! CGFloat,
    // gv.getConfigValue("navigationItemCartImgWidth") as! CGFloat,
    // gv.getConfigValue("navigationItemCartImgHeight") as! CGFloat)
    //
    // buttonCart.setImage(UIImage(named: gv.getConfigValue("navigationItemCartImgName") as! String), forState: UIControlState.Normal)
    // buttonCart.addTarget(self, action: "navItemCartClick:", forControlEvents: UIControlEvents.TouchUpInside)
    // let rightBarButtonItemCart = UIBarButtonItem(customView: buttonCart)
    //
    // //Search
    // let buttonSearch = UIButton(type: UIButtonType.Custom) as UIButton
    // buttonSearch.frame = CGRectMake(
    // gv.getConfigValue("navigationItemSearchImgPositionX") as! CGFloat,
    // gv.getConfigValue("navigationItemSearchImgPositionY") as! CGFloat,
    // gv.getConfigValue("navigationItemSearchImgWidth") as! CGFloat,
    // gv.getConfigValue("navigationItemSearchImgHeight") as! CGFloat)
    // buttonSearch.setImage(UIImage(named: gv.getConfigValue("navigationItemSearchImgName") as! String), forState: UIControlState.Normal)
    // buttonSearch.addTarget(self, action: "navItemSearchClick:", forControlEvents: UIControlEvents.TouchUpInside)
    // let rightBarButtonItemSearch = UIBarButtonItem(customView: buttonSearch)
    //
    //
    //
    // // add multiple right bar button items
    // self.navigationItem.setRightBarButtonItems([rightBarButtonItemSearch,rightBarButtonItemCart,rightBarButtonItemCall], animated: true)
    //
    // // uncomment to add single right bar button item
    // //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    // }
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
    // //Navigation Bar
    // func navItemFlightClick(sender:UIButton!)
    // {
    // self.removeNavigateView()
    // flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
    // flightViewController.showInView(self.view, animated: true)
    // }
    //
    // func navItemCallClick(sender:UIButton!)
    // {
    // self.removeNavigateView()
    // callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
    // callAssistanceViewController.showInView(self.view, animated: true)
    //
    // }
    //
    // func navItemCartClick(sender:UIButton!)
    // {
    // print("navItemCartClick")
    // let cartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
    // self.navigationController?.pushViewController(cartViewController!, animated: true)
    //
    // }
    //
    // func navItemSearchClick(sender:UIButton!)
    // {
    // print("navItemSearchClick")
    // let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
    // let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
    // searchViewController?.modalPresentationStyle = modalStyle
    // self.presentViewController(searchViewController!, animated: true, completion: nil)
    // }
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
    func setupTable(){
        //draw button
        for var index = 0; index < 6; ++index {
            var select = 0
            if index == 0{
                select = 1
            }
            else{
                select = 0
            }
            let image = UIImage(named: "tab-\(buttonName[index])\(select).png")
            let button = UIButton()
            button.frame = CGRectMake(CGFloat(22 + (index * 166)), 0, (image?.size.width)!/2, (image?.size.height)!/2)
            //button.frame = CGRectMake(CGFloat(22 + (index * 166)), 362.5, (image?.size.width)!/2, (image?.size.height)!/2)
            button.setImage(image, forState: .Normal)
            button.tag = select
            button.addTarget(self, action: "tappedProductCatagory:", forControlEvents: UIControlEvents.TouchUpInside)
            buttonList.append(button)
            //self.view.addSubview(buttonList[index])
            self.vCatagory.addSubview(buttonList[index])
        }
        //draw line
        for var index = 0; index < 5; ++index {
            let line = DrawLine(frame: CGRectMake(0, 0, 1000, 1000))
            line.startX = CGFloat(180 + (index * 166))
            //line.startY = CGFloat(362.5)
            line.startY = CGFloat(0)
            line.finishX = CGFloat(180 + (index * 166))
            //line.finishY = CGFloat(402.5)
            line.finishY = CGFloat(40)
            //self.view.addSubview(line)
            //self.view.sendSubviewToBack(line)
            self.vCatagory.addSubview(line)
            self.vCatagory.sendSubviewToBack(line)
        }
        // self.view.sendSubviewToBack(pcPromotion)
    }
    func tappedProductCatagory(sender:UIButton!){
        //clear all select
        for var index = 0; index < 6; ++index {
            var select = 0
            if sender == buttonList[index] {
                select = 1
                self.getProductList(index)
            }
            else{
                select = 0
            }
            buttonList[index].tag = select
            let image = UIImage(named: "tab-\(buttonName[index])\(select).png")
            buttonList[index].setImage(image, forState: .Normal)
        }
       // self.tbvCatagory.reloadData()
    }
    @IBAction func exitFromThankyouPage(segue:UIStoryboardSegue){
        print("Back from thank you page")
    }
    

    
    func swipeProduct(sender:UIGestureRecognizer){
        // do other task
        if let gestureSwipe = sender as? UISwipeGestureRecognizer {
            switch gestureSwipe.direction {
            case UISwipeGestureRecognizerDirection.Up:
                print("UISwipeGestureRecognizerDirection.Up")
            case UISwipeGestureRecognizerDirection.Down:
                print("UISwipeGestureRecognizerDirection.Down")
            default:
                break
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if segue.identifier == "moreProductSegue" {
            let vc = segue.destinationViewController as! ViewController
            for var index = 0; index < 6; ++index {
                if buttonList[index].tag == 1 {
                    var productAllArray = []
                    if index == 0 {
                        productAllArray = ProductController().getProductByGender(String(gv.getConfigValue("genderWomen")))
                    }else{
                        productAllArray = ProductController().getProductByProductGroupID(Int32(index))
                    }
                    vc.productArray = productAllArray as! [ProductModel]
                }
            }
            
        }
    //(segue.destinationViewController as! DetailViewController).detailText = String(cell.labelIndex.text)
    //let cell = sender as! MyCustomCollectionViewCell
    //print(self.tbv.
    //print(cell.labelIndex.text)
    //print(indexPath?.row)
    }
    
}
