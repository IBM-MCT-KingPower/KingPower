//
//  DetailPresentationController.swift
//  PresentationTutorial
//
//  Created by Sztanyi Szabolcs on 17/11/14.
//  Copyright (c) 2014 Sztanyi Szabolcs. All rights reserved.
//

import UIKit

class DetailPresentationController: UIPresentationController {
    
    var dimmingView: UIView!
    var width:CGFloat = 600
    var height:CGFloat = 500
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        setupDimmingView()
    }
    
    func setupDimmingView() {
        dimmingView = UIView(frame: presentingViewController.view.bounds)
        
        dimmingView = UIView(frame: presentingViewController.view.bounds)
        dimmingView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        //var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        //visualEffectView.frame = dimmingView.bounds
        //visualEffectView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        //visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        //dimmingView.addSubview(visualEffectView)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "dimmingViewTapped:")
        dimmingView.addGestureRecognizer(tapRecognizer)
    }
    
    func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView
        let presentedViewController = self.presentedViewController
        
        dimmingView.frame = containerView!.bounds
        dimmingView.alpha = 0.0
        
        containerView!.insertSubview(dimmingView, atIndex: 0)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (coordinatorContext) -> Void in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (coordinatorContext) -> Void in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = containerView!.bounds
        presentedView()!.frame = frameOfPresentedViewInContainerView()
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let currentDevice = UIDevice.currentDevice().userInterfaceIdiom
        //return CGSizeMake(parentSize.width - 80.0, parentSize.height - 160.0)
        self.screenWidth = parentSize.width
        self.screenHeight = parentSize.height
        return CGSizeMake(width, height)
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = containerView!.bounds
        
        let contentContainer = presentedViewController
        presentedViewFrame.size = sizeForChildContentContainer(contentContainer, withParentContainerSize: containerBounds.size)
        print(self.screenWidth/2)
        print(width/2)
        presentedViewFrame.origin.x = (self.screenWidth/2)-(width/2)
        presentedViewFrame.origin.y = (self.screenHeight/2)-(height/2)
        
        return presentedViewFrame
    }
}