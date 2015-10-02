//
//  DrawLine.swift
//  LMoS2
//
//  Created by Patis Piriyahaphan on 1/14/15.
//  Copyright (c) 2015 EDCM. All rights reserved.
//

import UIKit
class DrawLine: UIView {
    var startX:CGFloat = 0;
    var startY:CGFloat = 0;
    var finishX:CGFloat = 0;
    var finishY:CGFloat = 0;
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        // Get the Graphics Context
        var context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, UIColor(hexString: "E0E0E0").CGColor)
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        
        var p = CGPoint()
        //p.x = 50
        //p.y = 0
        p.x = CGFloat(self.startX)
        p.y = CGFloat(self.startY)
        CGContextMoveToPoint(context, p.x, p.y)
        CGContextAddLineToPoint(context, CGFloat(finishX), CGFloat(finishY))
        // Draw
        CGContextStrokePath(context)
    }
}
