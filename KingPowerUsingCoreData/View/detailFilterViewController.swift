//
//  detailFilterViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit


protocol filterDetailDelegate {
    /*
    func addSubcat (prodCat:ProductCategoryModel)
    func addBrandList (brandList:NSMutableArray)
    func addGender (gender:String)
    func addPriceRange (range:String)
    func addColor (colorList:NSMutableArray)*/
    func addSubcat (prodCatIndex:Int)
    func addBrandList (brandIndexList:NSMutableArray)
    func addGender (genderIndex:Int)
    func addPriceRange (rangeIndex:Int)
    func addColor (colorIndexList:NSMutableArray)
  //  func getProdCatList(prodCatList : [ProductCategoryModel])
  //  func getBrandList(brandList : [BrandModel])
}

class detailFilterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var delegate:filterDetailDelegate?
    @IBOutlet weak var filterDetailTable: UITableView!
    var filterDetailSubCat:[ProductCategoryModel] = []  // select 1 subcat
    var filterDetailBrand:[BrandModel] = []             // select more than 1
    var filterDetailGender:[String] = KPVariable.genderList //Select 1 gender
    var filterDetailPriceRange:[String] = KPVariable.priceRangeList          // select 1 range
    var filterDetailColor:[String] = KPVariable.colorList                 // Select more than 1
    /*
    var filterSubCat = ProductCategoryModel()
    var filterBrand:NSMutableArray = NSMutableArray()
    var filterGender:String = ""
    var filterPriceRange:String = ""
    var filterColor:NSMutableArray = NSMutableArray()
    */
    var filterSubCatIndex:Int = -1
    var filterBrandIndex:NSMutableArray = NSMutableArray()
    var filterGenderIndex:Int = -1
    var filterPriceRangeIndex:Int = -1
    var filterColorIndex:NSMutableArray = NSMutableArray()
    var selectedIndexMain = 0
    var tmpFilterSubCatIndex:Int = -1
    var tmpFilterBrandIndex:NSMutableArray = NSMutableArray()
    var tmpFilterGenderIndex:Int = -1
    var tmpFilterPriceRangeIndex:Int = -1
    var tmpFilterColorIndex:NSMutableArray = NSMutableArray()
    
    var indexpath:NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(animated: Bool) {
        tmpFilterSubCatIndex = filterSubCatIndex
        tmpFilterBrandIndex = filterBrandIndex.mutableCopy() as! NSMutableArray
        tmpFilterGenderIndex = filterGenderIndex
        tmpFilterPriceRangeIndex = filterPriceRangeIndex
        tmpFilterColorIndex = filterColorIndex.mutableCopy() as! NSMutableArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if selectedIndexMain == 0 {
            print("DetailFilterViewController : Done Action \(filterSubCatIndex)")
            delegate!.addSubcat(tmpFilterSubCatIndex)
        }else if selectedIndexMain == 1 {
            delegate!.addBrandList(tmpFilterBrandIndex)
        }else if selectedIndexMain == 2 {
            delegate!.addGender(tmpFilterGenderIndex)
        }else if selectedIndexMain == 3 {
            delegate!.addPriceRange(tmpFilterPriceRangeIndex)
        }else if selectedIndexMain == 4 {
            delegate!.addColor(tmpFilterColorIndex)
        }
    }

    @IBAction func doneAction(sender: AnyObject) {
        if selectedIndexMain == 0 {
            print("DetailFilterViewController : Done Action \(filterSubCatIndex)")
            delegate!.addSubcat(filterSubCatIndex)
        }else if selectedIndexMain == 1 {
            delegate!.addBrandList(filterBrandIndex)
        }else if selectedIndexMain == 2 {
            delegate!.addGender(filterGenderIndex)
        }else if selectedIndexMain == 3 {
            delegate!.addPriceRange(filterPriceRangeIndex)
        }else if selectedIndexMain == 4 {
            delegate!.addColor(filterColorIndex)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndexMain == 0 {
            return self.filterDetailSubCat.count
        }else if selectedIndexMain == 1 {
            return self.filterDetailBrand.count
        }else if selectedIndexMain == 2 {
            return self.filterDetailGender.count
        }else if selectedIndexMain == 3 {
            return self.filterDetailPriceRange.count
        }else if selectedIndexMain == 4 {
            return self.filterDetailColor.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifierID = "detailCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierID) as! filterDetailTableViewCell?
        print("DetailViewController : \(filterSubCatIndex), \(filterBrandIndex), \(filterGenderIndex), \(filterPriceRangeIndex), \(filterColorIndex)")
        if selectedIndexMain == 0 {
            if indexPath.row == filterSubCatIndex {
                cell?.markImage.image = UIImage(named: "check")
                self.indexpath = indexPath
            }
            cell?.detailLabel!.text = self.filterDetailSubCat[indexPath.row].prc_name
        }else if selectedIndexMain == 1 {
            var ind = 0
            for index in filterBrandIndex {
                ind = index as! Int
                if indexPath.row == ind {
                    cell?.markImage.image = UIImage(named: "check")
                    self.indexpath = indexPath
                    break
                }
            }
            cell?.detailLabel!.text = self.filterDetailBrand[indexPath.row].bran_name
        }else if selectedIndexMain == 2 {
            if indexPath.row == filterGenderIndex {
                cell?.markImage.image = UIImage(named: "check")
                self.indexpath = indexPath
            }
            cell?.detailLabel!.text = self.filterDetailGender[indexPath.row]
        }else if selectedIndexMain == 3 {
            if indexPath.row == filterPriceRangeIndex {
                cell?.markImage.image = UIImage(named: "check")
                self.indexpath = indexPath
            }
            cell?.detailLabel!.text = self.filterDetailPriceRange[indexPath.row]
        }else if selectedIndexMain == 4 {
            var ind = 0
            for index in filterColorIndex {
                ind = index as! Int
                if indexPath.row == ind {
                    cell?.markImage.image = UIImage(named: "check")
                    self.indexpath = indexPath
                    break
                }
            }
            cell?.detailLabel!.text = self.filterDetailColor[indexPath.row]
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! filterDetailTableViewCell?
        if selectedIndexMain == 0 {
            //filterSubCat = filterDetailSubCat[indexPath.row]
            filterSubCatIndex = indexPath.row
            print("DetailFilterViewController : Add Sub Cat \(filterSubCatIndex)")
            cell?.markImage.image = UIImage(named: "check")
            if let indexpath1 = indexpath {
                let oldCell = tableView.cellForRowAtIndexPath(indexpath1) as! filterDetailTableViewCell?
                oldCell?.markImage.image = nil
                self.indexpath = nil
            }
        }else if selectedIndexMain == 1 {
            if cell?.markImage.image == nil {
                filterBrandIndex.addObject(indexPath.row)
                //filterBrand.addObject(filterDetailBrand[indexPath.row])
                cell?.markImage.image = UIImage(named: "check")
            }else{
                filterBrandIndex.removeObject(indexPath.row)
                //filterBrand.removeObject(filterDetailBrand[indexPath.row])
                cell?.markImage.image = nil
            }
        }else if selectedIndexMain == 2 {
            filterGenderIndex = indexPath.row
            //filterGender = filterDetailGender[indexPath.row]
            cell?.markImage.image = UIImage(named: "check")
            if let indexpath1 = indexpath {
                let oldCell = tableView.cellForRowAtIndexPath(indexpath1) as! filterDetailTableViewCell?
                oldCell?.markImage.image = nil
                self.indexpath = nil
            }
        }else if selectedIndexMain == 3 {
            filterPriceRangeIndex = indexPath.row
            //filterPriceRange = filterDetailPriceRange[indexPath.row]
            cell?.markImage.image = UIImage(named: "check")
            if let indexpath1 = indexpath {
                let oldCell = tableView.cellForRowAtIndexPath(indexpath1) as! filterDetailTableViewCell?
                oldCell?.markImage.image = nil
                self.indexpath = nil
            }
        }else if selectedIndexMain == 4 {
            if cell?.markImage.image == nil {
                filterColorIndex.addObject(indexPath.row)
                //filterColor.addObject(filterDetailColor[indexPath.row])
                cell?.markImage.image = UIImage(named: "check")
            }else{
                filterColorIndex.removeObject(indexPath.row)
                //filterColor.removeObject(filterDetailColor[indexPath.row])
                cell?.markImage.image = nil
                
            }
        }

        
 
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = filterDetailTable.cellForRowAtIndexPath(indexPath) as! filterDetailTableViewCell?
        if selectedIndexMain == 0 {
            print("deselect")
            filterSubCatIndex = -1
            cell?.markImage.image = nil
        }
        else if selectedIndexMain == 2 {
            filterGenderIndex = -1
             cell?.markImage.image = nil
        }else if selectedIndexMain == 3 {
            filterPriceRangeIndex = -1
            cell?.markImage.image = nil
        }
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
