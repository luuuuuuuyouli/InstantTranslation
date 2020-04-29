//
//  BaseViewController.swift
//  LeaseOfOffice
//
//  Created by syong on 2019/7/10.
//  Copyright © 2019年 com.sy. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    private var interDelegate:UIGestureRecognizerDelegate?
    
   override var title: String?{
        didSet{
            titleLabel.text = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        self.initalizeNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationController?.viewControllers.count == 1{
            self.backButton.isHidden = true
        }else{
            self.backButton.isHidden = false
            interDelegate = self.navigationController?.interactivePopGestureRecognizer?.delegate
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = interDelegate
     
    }
    func initalizeNavigationBar() -> Void {
        
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets = UIEdgeInsets.init(top: 44, left: 0, bottom: 0, right: 0)
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(self.barView)
        self.view.addSubview(self.statusView)

        self.barView.addSubview(self.titleLabel)
        self.barView.addSubview(self.backButton)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.barView)
            make.centerX.equalTo(self.barView)
        };
    }

    
    //导航栏
    lazy var barView:UIView = {
       
        let bar = UIView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT(), width: SCREEN_WIDTH(), height: 44))
        bar.backgroundColor = UIColor.white
        return bar

    }()
    //状态栏
    lazy var statusView:UIView = {
        
        let status = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH(), height: STATUS_BAR_HEIGHT()))
        status.backgroundColor = UIColor.white
        return status
        
    }()
    //标题
    lazy var titleLabel:UILabel = {
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 25))
        titleLabel.textColor = COLOR_16(value: 0x313C4F)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    //返回按钮
    lazy var backButton:UIButton = {
    
        let back = UIButton.init()
        back.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        back.setImage(UIImage.init(named: "icon_fanhuibaise"), for: UIControl.State.normal)
        back.imageEdgeInsets =  UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        back.addTarget(self, action: #selector(backLastPage), for: UIControl.Event.touchUpInside)
        back.isHidden = true
        return back
    }()
    
    @objc func backLastPage() -> Void {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension BaseViewController:UIGestureRecognizerDelegate{
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return self.navigationController?.children.count ?? 1 > 1;
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.navigationController?.viewControllers.count ?? 1 > 1
    }
}
