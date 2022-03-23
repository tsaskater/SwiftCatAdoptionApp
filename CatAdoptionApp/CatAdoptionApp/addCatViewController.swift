//
//  addCatViewController.swift
//  CatAdoptionApp
//
//  Created by administrator on 2022. 03. 06..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class addCatViewController: UIViewController {
    var newCat:Cat?=nil
    
    @IBOutlet weak var catNameTextField: UITextField!
    
    @IBOutlet weak var birthDateDatePicker: UIDatePicker!
    
    @IBOutlet weak var genderButton: UIButton!
    @IBAction func genderButtonClick(_ sender: Any) {
        if genderButton.currentTitle! == "Female" {
            genderButton.setTitle("Male", for: .normal)
            genderButton.backgroundColor = UIColor.systemTeal
            }
        else {
            genderButton.setTitle("Female", for: .normal)
            genderButton.backgroundColor = UIColor.systemPink
        }
    }
    @IBOutlet weak var arriveToShelterDatePicker: UIDatePicker!
    @IBOutlet weak var neuteringDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target:self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneAddCat"{
            newCat = Cat(name: catNameTextField.text!, birthDate: birthDateDatePicker.date as NSDate, arriveToShelter: arriveToShelterDatePicker.date as NSDate, neuteringDate: neuteringDatePicker.date as NSDate, gender: genderButton.currentTitle! == "Female" ? false : true)
            
        }
    }
   
}
/*extension UIViewController{
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target:self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
       }
   @objc func dismissKeyboard(){
       view.endEditing(true)
   }
}*/
