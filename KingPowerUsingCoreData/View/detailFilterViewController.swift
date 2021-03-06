//
//  detailFilterViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit


protocol filterDetailDelegate {
    func addSubcatList (prodCatIndexList:NSMutableArray)
    func addBrandList (brandIndexList:NSMutableArray)
    func addGender (genderIndex:Int)
    func addPriceRange (rangeIndex:Int)
    func addColorList (colorIndexList:NSMutableArray)
}

class detailFilterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var delegate:filterDetailDelegate?
    @IBOutlet weak var filterDetailTable: UITableView!
    var filterDetailSubCat:[ProductCategoryModel] = []  // select 1 subcat
    var filterDetailBrand:[BrandModel] = []             // select more than 1
    var filterDetailGender:[String] = KPVariable.genderList //Select 1 gender
    var filterDetailPriceRange:[String] = KPVariable.priceRangeList          // select 1 range
    var filterDetailColor:[String] = KPVariable.colorList                 // Select more than 1

    var filterSubCatIndex:NSMutableArray = NSMutableArray()
    var filterBrandIndex:NSMutableArray = NSMutableArray()
    var filterGenderIndex:Int = -1
    var filterPriceRangeIndex:Int = -1
    var filterColorIndex:NSMutableArray = NSMutableArray()
    var selectedIndexMain = 0
    var tmpFilterSubCatIndex:NSMutableArray = NSMutableArray()
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
        tmpFilterSubCatIndex = filterSubCatIndex.mutableCopy() as! NSMutableArray
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
            delegate!.addSubcatList(tmpFilterSubCatIndex)
        }else if selectedIndexMain == 1 {
            delegate!.addBrandList(tmpFilterBrandIndex)
        }else if selectedIndexMain == 2 {
            delegate!.addGender(tmpFilterGenderIndex)
        }else if selectedIndexMain == 3 {
            delegate!.addPriceRange(tmpFilterPriceRangeIndex)
        }else if selectedIndexMain == 4 {
            delegate!.addColorList(tmpFilterColorIndex)
        }
    }

    @IBAction func doneAction(sender: AnyObject) {
        if selectedIndexMain == 0 {
            delegate!.addSubcatList(filterSubCatIndex)
        }else if selectedIndexMain == 1 {
            delegate!.addBrandList(filterBrandIndex)
        }else if selectedIndexMain == 2 {
            delegate!.addGender(filterGenderIndex)
        }else if selectedIndexMain == 3 {
            delegate!.addPriceRange(filterPriceRangeIndex)
        }else if selectedIndexMain == 4 {
            delegate!.addColorList(filterColorIndex)
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
        print("DetailViewController : \(selectedIndexMain), \(filterSubCatIndex), \(filterBrandIndex), \(filterGenderIndex), \(filterPriceRangeIndex), \(filterColorIndex)")
        if selectedIndexMain == 0 {
            if filterSubCatIndex.filter({ ($0 as! Int)  == indexPath.row }).count > 0 {
                cell?.markImage.hidden = false
                self.indexpath = indexPath
            }else{
                cell?.markImage.hidden = true
            }
            cell?.detailLabel!.text = self.filterDetailSubCat[indexPath.row].prc_name
        }else if selectedIndexMain == 1 {
            if filterBrandIndex.filter({ ($0 as! Int)  == indexPath.row }).count > 0 {
                cell?.markImage.hidden = false
                self.indexpath = indexPath
            }else{
                cell?.markImage.hidden = true
            }
            cell?.detailLabel!.text = self.filterDetailBrand[indexPath.row].bran_name
        }else if selectedIndexMain == 2 {
            if indexPath.row == filterGenderIndex {
                cell?.markImage.hidden = false
                self.indexpath = indexPath
            }else{
                cell?.markImage.hidden = true
            }
            cell?.detailLabel!.text = self.filterDetailGender[indexPath.row]
        }else if selectedIndexMain == 3 {
            if indexPath.row == filterPriceRangeIndex {
                cell?.markImage.hidden = false
                self.indexpath = indexPath
            }else{
                cell?.markImage.hidden = true
            }
            cell?.detailLabel!.text = self.filterDetailPriceRange[indexPath.row]
        }else if selectedIndexMain == 4 {
            if filterColorIndex.filter({ ($0 as! Int)  == indexPath.row }).count > 0 {
                cell?.markImage.hidden = false
                self.indexpath = indexPath
            }else{
                cell?.markImage.hidden = true
            }
            cell?.detailLabel!.text = self.filterDetailColor[indexPath.row]
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("Select row \(indexPath.row)")
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! filterDetailTableViewCell?
        if selectedIndexMain == 0 {
            if cell?.markImage.hidden == true {
                filterSubCatIndex.addObject(indexPath.row)
            }else{
                filterSubCatIndex.removeObject(indexPath.row)
            }
        }else if selectedIndexMain == 1 {
            if cell?.markImage.hidden == true {
                filterBrandIndex.addObject(indexPath.row)
            }else{
                filterBrandIndex.removeObject(indexPath.row)
            }
        }else if selectedIndexMain == 2 {
            filterGenderIndex = indexPath.row
        }else if selectedIndexMain == 3 {
            filterPriceRangeIndex = indexPath.row
        }else if selectedIndexMain == 4 {
            if cell?.markImage.hidden == true {
                filterColorIndex.addObject(indexPath.row)
            }else{
                filterColorIndex.removeObject(indexPath.row)
            }
        }

        tableView.reloadData()
 
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
