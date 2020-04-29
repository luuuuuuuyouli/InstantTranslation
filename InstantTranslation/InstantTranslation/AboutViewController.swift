//
//  AboutViewController.swift
//  InstantTranslation
//
//  Created by syong on 2020/3/26.
//  Copyright © 2020 com.syong. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 0
        tableView.register(UINib.init(nibName: "DSMineTableViewCell", bundle: nil), forCellReuseIdentifier: "DSMineTableViewCell")
    }


    @IBAction func backHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension AboutViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DSMineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSMineTableViewCell") as! DSMineTableViewCell
        cell.selectionStyle = .none
        cell.pic.image = UIImage.init(named: indexPath.row == 0 ? "icon_guanyuwomen" : "icon_yijianfankui")
        cell.titleL.text =  indexPath.row == 0 ? "About us" : "Feedback"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = SYAboutViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SYFeedBackViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
