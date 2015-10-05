//
//  FlightViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 10/4/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class FlightViewController: UIViewController {

    
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vMain: UIView!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var lblFlight: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        //self.vMain.frame = CGRectMake(0, 80, 1024, 500)
        //self.vContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        let gesture1 = UITapGestureRecognizer(target: self, action: "tappedView:")
        self.vContainer.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: "tappedView:")
        self.vMain.addGestureRecognizer(gesture2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showInView(aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)
        if animated
        {
            self.showAnimate()
        }
    }
    func showAnimate()
    {
        self.vMain.alpha = 0.0;
        self.vContainer.alpha = 0.0;
        //self.vMain.frame = CGRectMake(0, -200, 1024, 200)
        UIView.animateWithDuration(0.5, animations: {
            self.vMain.alpha = 1.0
            self.vMain.center.y = 500
            self.vContainer.alpha = 0.5
            self.vContainer.center.y = 1000
        });
    }
    
    
    @IBAction func okTapped(sender: AnyObject) {
        removeAnimate()
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.5, animations: {
            self.vMain.alpha = 0.0
            self.vMain.center.y = -500
            self.vContainer.alpha = 0.0
            self.vContainer.center.y = -1000
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    func tappedView(sender:UITapGestureRecognizer){
        // do other task
        removeAnimate()
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
