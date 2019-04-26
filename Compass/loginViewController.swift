//
//  loginViewController.swift
//  Compass
//
//  Created by Анастасия Латыш on 26/04/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.login.delegate = self
        self.password.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var password: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
