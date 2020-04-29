//
//  SYFeedBackViewController.swift
//  BasePorject
//
//  Created by syong on 2019/7/24.
//  Copyright © 2019年 com.sy. All rights reserved.
//

import UIKit

class SYFeedBackViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func submit(_ sender: Any) {
        
        SVProgressHUD.showSuccess(withStatus: "Submitted successfully")
        
    }
    

}
