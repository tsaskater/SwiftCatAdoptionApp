//
//  CatCard.swift
//  CatAdoptionApp
//
//  Created by administrator on 2022. 03. 05..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit

class CatCard: UITableViewCell {

    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthDayLabel: UILabel!
    
    @IBOutlet weak var arriveToShelterLabel: UILabel!
    
    @IBOutlet weak var neuteringDateLabel: UILabel!
    
    @IBOutlet weak var adotpedByLabel: UILabel!
    
    
    @IBOutlet weak var adoptionDateLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    // Cell setup
    func configure(name:String,birthDay:String,arriveToShelter:String,neuteringDate:String,adoptedByName:String? = nil,adoptionDate:String?=nil,gender:Bool){
        nameLabel.text = "Name: " + name
        birthDayLabel.text = "Birthday: " + birthDay
        arriveToShelterLabel.text = "Arrival to shelter: " + arriveToShelter
        neuteringDateLabel.text = "Neutering date: " + neuteringDate
        if adoptedByName != nil{
            adotpedByLabel.text = "Adopted by: \(adoptedByName!)"
        }
        if adoptionDate != nil{
            adoptionDateLabel.text = "Adoption date: \(adoptionDate!)"
        }
        if gender == true {
            genderLabel.text = "♂"
            genderLabel.textColor = UIColor.systemBlue
        }
        else {
            genderLabel.text = "♀"
            genderLabel.textColor = UIColor.systemPink
        }
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0,height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 2.0
    }
}
