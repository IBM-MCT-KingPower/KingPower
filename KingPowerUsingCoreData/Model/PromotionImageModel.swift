//
//  PromotionImageModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PromotionImageModel{
    
    var prmi_id       : Int32 = 0
    var prmi_prom_id    : Int32 = 0
    var prmi_img_seq    : Int32 = 0
    var prmi_img_path : String = ""
    
    var queryGetPromotionImageById : String = "SELECT PRMI_ID, PRMI_PROM_ID, PRMI_IMG_SEQ, PRMI_IMG_PATH FROM PROMOTION_IMAGE WHERE PRMI_ID = %@ ORDER BY PRMI_PROM_ID, PRMI_IMG_SEQ;"
    
    var queryGetPromotionImageByPromotionId : String = "SELECT PRMI_ID, PRMI_PROM_ID, PRMI_IMG_SEQ, PRMI_IMG_PATH FROM PROMOTION_IMAGE WHERE PRMI_PROM_ID = %@ ORDER BY PRMI_IMG_SEQ;"
    
    
}