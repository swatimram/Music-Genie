//
//  ViewController.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 6/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        self.hideKeyboard()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

