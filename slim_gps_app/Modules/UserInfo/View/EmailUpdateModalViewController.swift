//
//  EmailUpdateModalViewController.swift
//  slim_gps_app
//
//  Created by 福原佑介 on 2018/12/27.
//  Copyright © 2018 yusuke. All rights reserved.
//

import UIKit

class EmailUpdateModalViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfField: UITextField!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.text = email
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
