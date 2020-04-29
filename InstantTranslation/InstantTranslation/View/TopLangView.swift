//
//  TopLangView.swift
//  InstantTranslation
//
//  Created by syong on 2020/3/25.
//  Copyright © 2020 com.syong. All rights reserved.
//

import UIKit


typealias changeLanBlock = (_ one:String,_ two:String) ->Void


class TopLangView: UIView {
    
    var changeLanBlock:changeLanBlock?

    @IBOutlet weak var oneLang: UILabel!
    @IBOutlet weak var twoLang: UILabel!
    
    var transDic = [
        "Chinese": "zh",
        "English":"en",
        "Japanese":"jp",
        "Korean":"kor",
        "Spanish":"spa",
        "French":"fra",
        "German":"de",
        "Russian":"ru"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func changLang(_ sender: Any) {
        
        if oneLang.text == "Auto" {
            return
        }
        
        let text = oneLang.text
        oneLang.text = twoLang.text
        twoLang.text = text
        
        
        let keyOne = transDic[oneLang.text!]
        let KeyTwo = transDic[twoLang.text!]
        
        if self.changeLanBlock != nil{
            self.changeLanBlock!(keyOne!,KeyTwo!)
        }
        
    }
    
}
