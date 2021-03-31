//
//  HelloViewController.swift
//  LoginApp
//
//  Created by Артем Ермак on 3/30/21.
//

import UIKit

class HelloViewController: UIViewController {
    
    var helloUserName: String!
    
    @IBOutlet var helloUserTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let helloUserName = helloUserName else { return }
        helloUserTitle.text = "Hello 🖖, \(helloUserName)"
    }
    
    @IBAction func logOutAction() {
       performSegue(withIdentifier: "unwindSegue", sender: nil)
    }

}
