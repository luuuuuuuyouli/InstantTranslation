//
//  UIView+shadow.swift
//  BasePorject
//
//  Created by syong on 2019/7/30.
//  Copyright © 2019年 com.sy. All rights reserved.
//

import Foundation


extension UIView{
    
    func setShadowLayer(color:UIColor,offset:CGFloat,radius:CGFloat,shadowOpacity:Float) -> Void {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: offset)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = radius
    }
    
    
}
