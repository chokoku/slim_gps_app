//
//  SpotInputViewController.swift
//  slim_gps_app
//
//  Created by 福原佑介 on 2018/12/27.
//  Copyright © 2018 yusuke. All rights reserved.
//

import UIKit

class SpotInputViewController: UIViewController {

    @IBOutlet weak var spotName: UITextField!
    @IBOutlet weak var modalTitle: UILabel!
    var inputTitle: String!
    var originalName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalTitle.text = inputTitle
        spotName.text = originalName
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
