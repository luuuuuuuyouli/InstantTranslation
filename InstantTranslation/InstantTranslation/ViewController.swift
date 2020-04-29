//
//  ViewController.swift
//  InstantTranslation
//
//  Created by syong on 2020/3/24.
//  Copyright © 2020 com.syong. All rights reserved.
//

import UIKit
import AVKit

class ViewController: BaseViewController {

   // @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [[String:String]]()
    
    var fromType = "en"//自动
    var toType = "zh"//中文
    
    var transArray = ["zh","en","jp","kor","spa","fra","de","ru"]
    
    var langDic = [
        "zh":"zh-CN",
        "en":"en-US",
        "jp":"ja-JP",
        "kor":"ko-KR",
        "spa":"es-ES",
        "fra":"fr-FR",
        "de":"de-DE",
        "ru":"ru-RU"
    ]
    var nowContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "Translation"
    
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        configUI()
    }
    
    
    
    func configUI() -> Void {
        self.view.addSubview(self.tableView)
        self.view.addSubview(bottomView)
        self.bottomView.addSubview(textField)
        self.bottomView.addSubview(transBtn)
        self.view.addSubview(self.topLangView)
        
        self.topLangView.changeLanBlock = {[weak self] (one:String,two:String) in
            guard let `self` = self else{
                    return
            }
//            self.fromType = one
            self.toType = two
        }
        
        
        let mineBtn = UIButton.init(frame: CGRect.init(x: 15, y: 5, width: 30, height: 30))
        mineBtn.setImage(UIImage.init(named: "icon_guanyuwomen"), for: .normal)
        mineBtn.addTarget(self, action: #selector(mineClick), for: .touchUpInside)
        self.barView.addSubview(mineBtn)
        
        hideKeyboardWhenTap()
    }
    //tablview
    lazy var tableView:UITableView = {
       
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: NAV_HEIGHT()+43, width: SCREEN_WIDTH(), height: SCREEN_HEIGHT()-NAV_HEIGHT()-TAB_BAR_Safe_HEIGHT()-56-43), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "LeftTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftTableViewCell")
        tableView.register(UINib.init(nibName: "RightTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTableViewCell")
        return tableView
        
    }()

    //底部视图
    lazy var bottomView:UIView = {
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT()-TAB_BAR_Safe_HEIGHT()-56, width: SCREEN_WIDTH(), height: TAB_BAR_Safe_HEIGHT()+56))
        bottomView.backgroundColor = COLOR_16(value: 0xdedede)
        return bottomView
    }()
    //输入框
    lazy var textField:UITextField = {
        let textField = UITextField.init()
        textField.frame = CGRect.init(x: 25, y: 10, width: WIDTH_CONSTARIN(width: 240), height: 35)
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.layer.cornerRadius = 3
        NotificationCenter.default.addObserver(self, selector: #selector(getNowText(sender:)), name:UITextField.textDidChangeNotification, object: nil)
        return textField
    }()
    
    //翻译按钮
    lazy var transBtn:UIButton = {
        let transBtn = UIButton.init()
        transBtn.frame = CGRect.init(x: SCREEN_WIDTH() - 100, y: 10, width: 75, height: 28)
        transBtn.backgroundColor = COLOR_16(value: 0x313C4F)
        transBtn.setTitle("translate", for: .normal)
        transBtn.setTitleColor(UIColor.white, for: .normal)
        transBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        transBtn.layer.cornerRadius = 5
        transBtn.addTarget(self, action: #selector(action_tran), for: .touchUpInside)
        return transBtn
    }()
    //选择语言
    lazy var pickView:PickLanView = {
        let pickView = Bundle.main.loadNibNamed("PickLanView", owner: nil, options: nil)?.last as! PickLanView
        pickView.frame = CGRect.init(x:0, y: 0, width: SCREEN_WIDTH(), height: SCREEN_HEIGHT())
        pickView.backgroundColor =  COLOR_RGB(r: 49, g: 60, b: 79, a: 0.3)
        return pickView
    }()
    //语言视图
    lazy var topLangView:TopLangView = {
       
        let topLangView = Bundle.main.loadNibNamed("TopLangView", owner: nil, options: nil)?.last as! TopLangView
        topLangView.frame = CGRect.init(x: 10, y: NAV_HEIGHT(), width: SCREEN_WIDTH()-20, height: 43)
        topLangView.backgroundColor = COLOR_RGB(r: 49, g: 60, b: 79, a: 0.09)
        topLangView.layer.cornerRadius = 10
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(showPiclangView))
        topLangView.addGestureRecognizer(tap)
        return topLangView
        
    }()
    
    
    //键盘出现
    @objc func keyboardWillShow(notification:Notification){
        let userinfo:Dictionary = notification.userInfo!
        let Keyframe = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
        let duration = (userinfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
      
        UIView.animate(withDuration: duration) {
            self.bottomView.frame.size.height = 56
            self.bottomView.frame.origin.y =  SCREEN_HEIGHT() - Keyframe.size.height - 56
            self.tableView.frame.size.height = SCREEN_HEIGHT() - NAV_HEIGHT() - 56 - Keyframe.size.height - 43
            self.scrollToBottom()
        }
    }
    //键盘隐藏
    @objc func keyboardWillHide(notification:Notification){
      
        UIView.animate(withDuration: 0.25) {
 
            self.bottomView.frame.origin.y = SCREEN_HEIGHT() - TAB_BAR_Safe_HEIGHT() - 56
            self.bottomView.frame.size.height = TAB_BAR_Safe_HEIGHT() + 56
            self.tableView.frame.size.height = SCREEN_HEIGHT()-NAV_HEIGHT()-TAB_BAR_Safe_HEIGHT()-56 - 43
        }

    }
    //获取文字高度
    func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText:NSString = textStr as NSString
        let size = CGSize.init(width: width, height: 1000)
        let dic = NSDictionary(object: font, forKey: kCTFontAttributeName as! NSCopying)
        let stringSiez = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (dic as! [NSAttributedString.Key : Any]), context: nil).size
        
        return stringSiez.height + 60
        
    }
    
    func scrollToBottom() -> Void {
        
        if dataSource.count > 0 {
            tableView.scrollToRow(at: IndexPath.init(row: dataSource.count-1, section: 0), at: .bottom, animated: false)
        }
        
    }
    //回收键盘
    func hideKeyboardWhenTap() -> Void {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissKetboard(sender:)))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKetboard(sender:UITapGestureRecognizer) {

        var point = sender.location(in: self.view)
        
        point = self.bottomView.layer.convert(point, from: self.view.layer)
        
        if !self.bottomView.layer.contains(point) {
             self.textField.resignFirstResponder()
        }
        
       
    }
    //翻译
    @objc func action_tran(){
        
        if nowContent.count > 0 {
            let dic = [
                "type":"2" ,
                "content":nowContent
                ]
            dataSource.append(dic)
            self.tableView.reloadData()
            self.scrollToBottom()
            self.getTranslatNetworking(content: nowContent)
            self.textField.text = ""
        }
    }


    @objc func showPiclangView(){
        
        self.textField.resignFirstResponder()
        
        self.pickView.pickLangBlock = {[weak self] (one:String,two:String,oneIndex:Int,twoIndex:Int)in
            guard let `self` = self else{
                return
            }
            self.topLangView.oneLang.text = one
            self.topLangView.twoLang.text = two
          //  self.fromType = self.transArray[oneIndex]
            self.toType = self.transArray[twoIndex]
        }
         UIApplication.shared.keyWindow?.addSubview(self.pickView)
    }
    
    /*  百度翻译请求  */
    func getTranslatNetworking(content:String) -> Void {
        
        let salt =  "1435660288"//String.init(format: "%d", Int.randomIntNumber(lower: 1, upper: 1000000))
        
        let md5Sing =  self.getSignStr(salt: salt,content: content)
        
        let query = content.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        let linkStr = "https://fanyi-api.baidu.com/api/trans/vip/translate?" + "q=\(query)" + "&from=\(fromType)&to=\(toType)"+"&appid=20200325000404955&salt=\(salt)&sign=\(md5Sing)"
        

        print(linkStr)
        SVProgressHUD.show()
        SYNetworking.httpGet([:], method: linkStr, success: { [weak self]  (data, jsonStr) in
            SVProgressHUD.dismiss()
            guard let `self` = self else{
                return
            }
            let dic = data as! [String:Any]
            
            if dic["error_code"] != nil{
                self.dataSource.append(["type":"1","content":"Sorry, we can't translate"])
                self.tableView.reloadData()
                self.scrollToBottom()
                return
            }
     
            let result = dic["trans_result"] as! [[String:Any]]
            let resultDic = result.first
            
            let contentDic = [
                "type":"1",
                "content":resultDic?["dst"] ?? "Sorry, we can't translate"
            ]
            self.dataSource.append(contentDic as! [String : String])

            self.tableView.reloadData()
            
            self.scrollToBottom()
            
        }) { (error) in
            SVProgressHUD.dismiss()
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
        
        
    
    }
    /*  百度翻译签名处理  */
    func getSignStr(salt:String,content:String) -> String {
        //appid+q+salt+密钥
        let query = content.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let queryStr = query?.replacingOccurrences(of: "%20", with: " ")
        let sign = "20200325000404955\(queryStr ?? "")\(salt)KSG3xrHk6yxNjxQHIEvN"
        let md5Sign =  sign.md5
        return md5Sign
        
    }
    
    @objc func mineClick(){
        let vc = AboutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func getNowText(sender:NSNotification){
        let textF = sender.object as? UITextField
        nowContent = textF?.text ?? ""
    }
    
    private lazy var player:AVSpeechSynthesizer = {
        
        let player = AVSpeechSynthesizer.init()
        player.delegate = self
        return player
    }()
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AVSpeechSynthesizerDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellData = dataSource[indexPath.row]
        
        return getTextHeigh(textStr:cellData["content"]!, font: UIFont(name: "PingFang-SC-Medium", size: 15)!, width: 200)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cellData = dataSource[indexPath.row]
        
        let type = cellData["type"]
        
        if type == "1" {
            let cell:LeftTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeftTableViewCell") as! LeftTableViewCell
            cell.selectionStyle = .none
            cell.content = cellData["content"] ?? "无数据"
            cell.playVoiceBlcok = {[weak self] (content:String) in
                guard let `self` = self else{
                    return
                }
                let utterance:AVSpeechUtterance = AVSpeechUtterance.init(string: content)
                utterance.rate = 0.4
                utterance.voice = AVSpeechSynthesisVoice.init(language: self.langDic[self.toType])
                       // 开始朗读
                self.player.speak(utterance)
                
            }
            return cell
        }
        
        let cell:RightTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RightTableViewCell") as! RightTableViewCell
        cell.selectionStyle = .none
        cell.content = cellData["content"] ?? "无数据"
        return cell
    }
    //回车
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.textField.text!.count > 0 {
            let dic = [
                "type":"2" ,
                "content":self.textField.text!
                ]
            dataSource.append(dic)
            self.tableView.reloadData()
            self.scrollToBottom()
            self.getTranslatNetworking(content: self.textField.text!)
            self.textField.text = ""
        }

        return true
    }
    
    
    
    
    
}


public extension Int {
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }
    /**
     生成某个区间的随机数
     */
     static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
}


extension String {
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
}
