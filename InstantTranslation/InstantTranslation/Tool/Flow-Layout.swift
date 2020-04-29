//
//  Flow-Layout.swift
//  DriverSubscribe
//
//  Created by syong on 2020/3/19.
//  Copyright © 2020 com.eios. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout{
    
    convenience init?(Inset insets:UIEdgeInsets,miniLineSpace:CGFloat,miniInterItemSpace:CGFloat,itemSize:CGSize) {
        self.init()
        self.sectionInset = insets
        self.minimumLineSpacing = miniLineSpace
        self.minimumInteritemSpacing = miniInterItemSpace
        self.itemSize = itemSize
        
    }
    
}
