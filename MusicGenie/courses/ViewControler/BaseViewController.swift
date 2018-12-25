//
//  BaseViewController.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 27/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


            
        //let rightBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.appInfoAction))
        let rightBarbutton = UIBarButtonItem(image: UIImage(named: "info"), style: .plain, target: self, action: #selector(self.appInfoAction))
        self.navigationItem.rightBarButtonItem = rightBarbutton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func appInfoAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppInfoViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
