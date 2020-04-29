//
//  PickLanView.swift
//  InstantTranslation
//
//  Created by syong on 2020/3/25.
//  Copyright © 2020 com.syong. All rights reserved.
//

import UIKit

typealias pickLangBlock = (_ one:String, _ two:String, _ oneIndex:Int, _ twoIndex:Int) ->Void

class PickLanView: UIView {

    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var pickLangBlock:pickLangBlock?
    //spa","fra","de","ru"
    var rightArry = [
        "Chinese",
        "English",
        "Japanese",
        "Korean",
        "Spanish",
        "French",
        "German",
        "Russian"
    ]
    
    var oneStr = "English"
    var twoStr = "Chinese"
    
    var oneIndex = 0
    var twoIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    @IBAction func yesClick(_ sender: Any) {
        
        if self.pickLangBlock != nil {
                self.pickLangBlock!(oneStr,twoStr,oneIndex,twoIndex)
        }
        
        self.removeFromSuperview()
    }
    
    @IBAction func noClick(_ sender: Any) {
         self.removeFromSuperview()
    }
    
}

extension PickLanView:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  component == 0 ? 1 : rightArry.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
       if component == 1 {
            return rightArry[row]
        }
        
        return "English"
                
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 1 {
            twoIndex  = row
            twoStr = rightArry[row]
        }
    }
    
    
    
}
