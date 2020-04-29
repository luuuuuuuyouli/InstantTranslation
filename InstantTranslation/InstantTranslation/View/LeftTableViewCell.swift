//
//  LeftTableViewCell.swift
//  InstantTranslation
//
//  Created by syong on 2020/3/24.
//  Copyright © 2020 com.syong. All rights reserved.
//

import UIKit

typealias playVoiceBlcok = (_ content:String) ->Void

class LeftTableViewCell: UITableViewCell {
    
    var playVoiceBlcok:playVoiceBlcok?
    
    var content = "这是一条测试数据" {
        didSet{
            contentL.text = content

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(backView)
        self.contentView.addSubview(voiceBtn)
        self.backView.addSubview(contentL)
        
    }
    

    override func layoutIfNeeded() {
        let height = getTextHeigh(textStr: content, font: UIFont(name: "PingFang-SC-Medium", size: 15)!, width: 200)
        let textWidth =  getTextWidth(textStr: content, font: UIFont(name: "PingFang-SC-Medium", size: 15)!, height: 25)
        
        self.backView.frame = CGRect.init(x: 11, y: 11, width: textWidth > 200 ? 230 : textWidth + 30, height: height+26)
        self.contentL.frame = CGRect.init(x: 15, y: 13, width: textWidth > 200 ? 200 : textWidth, height: height)
        
        self.voiceBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.backView.snp_right).offset(15)
            make.centerY.equalTo(self.backView.snp_centerY)
        }
    }
    
    lazy var contentL:UILabel = {
    
        let contentL = UILabel.init()
        contentL.textColor = COLOR_16(value: 0x313C4F)
        contentL.font = UIFont(name: "PingFang-SC-Medium", size: 15)
        contentL.numberOfLines = 0
        return contentL
        
    }()
    
    lazy var backView:UIView = {
        let backView = UIView.init()
        backView.backgroundColor = COLOR_16(value: 0xecedef)
        backView.layer.cornerRadius = 10
        return backView
    }()
    
    lazy var voiceBtn:UIButton = {
        let voiceBtn = UIButton.init()
        voiceBtn.setImage(UIImage.init(named: "icon_bofang"), for: .normal)
        voiceBtn.addTarget(self, action: #selector(aciton_playVoice), for: .touchUpInside)
        return voiceBtn
    }()

    func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText:NSString = textStr as NSString
        let size = CGSize.init(width: width, height: 1000)
        let dic = NSDictionary(object: font, forKey: kCTFontAttributeName as! NSCopying)
        let stringSiez = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context: nil).size
        
        return stringSiez.height
        
    }
    
    
    func getTextWidth(textStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let normalText:NSString = textStr as NSString
        let size = CGSize.init(width: 2000, height: height)
        let dic = NSDictionary(object: font, forKey: kCTFontAttributeName as! NSCopying)
        let stringSiez = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context: nil).size
        
        return stringSiez.width
        
    }
    
    @objc func aciton_playVoice(){
        
        self.playVoiceBlcok?(contentL.text ?? "none")
        
    }
}

