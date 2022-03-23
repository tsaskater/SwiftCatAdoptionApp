//
//  ViewController.swift
//  CatAdoptionApp
//
//  Created by administrator on 2022. 03. 05..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func upForAdoptionClick(_ sender: Any) {
        performSegue(withIdentifier: "toAwaitingCatsViewController", sender: nil)
    }
    
    @IBAction func adoptedClick(_ sender: Any) {
        performSegue(withIdentifier: "toAdoptedCatsViewController", sender: nil)
    }
}

