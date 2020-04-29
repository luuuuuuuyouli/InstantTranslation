//
//  AppDelegate.swift
//  InstantTranslation
//
//  Created by syong on 2020/3/24.
//  Copyright © 2020 com.syong. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
       // self.configIQ()
        self.window?.backgroundColor = COLOR_16(value: 0xdedede)
        
        return true
    }

    /// 设置IQKeyboard
      func configIQ() {
          let IQKBManager = IQKeyboardManager.shared
          IQKBManager.enable = true
          //控制点击背景是否收起键盘
          IQKBManager.shouldResignOnTouchOutside = true
          IQKBManager.enableAutoToolbar = false
          IQKBManager.toolbarManageBehaviour = .byPosition
      }


}

