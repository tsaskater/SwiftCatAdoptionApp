//
//  awaitingCatsViewController.swift
//  CatAdoptionApp
//
//  Created by administrator on 2022. 03. 05..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit
import RealmSwift

class awaitingCatsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    let realm = try! Realm()
    @IBOutlet weak var upForAdoptionTableView: UITableView!
    //var cats = ["Gézu","Boki","Ninja"]
    /*var awaitedCats = [Cat(name: "Gézu", birthDate: NSDate() , arriveToShelter: NSDate(), neuteringDate: NSDate()),
        Cat(name: "Boki", birthDate: NSDate() , arriveToShelter: NSDate(), neuteringDate: NSDate()),
        Cat(name: "Ninja", birthDate: NSDate() , arriveToShelter: NSDate(), neuteringDate: NSDate()),
        Cat(name: "Mad", birthDate: NSDate() , arriveToShelter: NSDate(), neuteringDate: NSDate()),
    ]*/
    var awaitedCats : [Cat] = []
    var catToAdopt: Cat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()*/
        loadSavedAwaitingCats()
    }
    func loadSavedAwaitingCats(){
        progressIndicator.isHidden = false
        var syncCats:[Cat] = []
        /*realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()*/
        let aCats = realm.objects(Cat.self)
        for cat in aCats {
            //print("REALMCAT: \(awaitedCats.count)" + cat.name)
            if !cat.adopted{
                syncCats.append(cat)
            }
                
        }
        
        OperationQueue.main.addOperation { () -> Void in
            self.awaitedCats=[]
            print("SYNC CATS LENGTH: \(syncCats.count)")
            self.awaitedCats = syncCats
            print("awaited CATS LENGTH: \(self.awaitedCats.count)")
            self.upForAdoptionTableView.reloadData()
            sleep(1)
            self.progressIndicator.isHidden = true
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return awaitedCats.count
    }
    // Define cell for use
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCard", for: indexPath) as! CatCard
        cell.configure(name: awaitedCats[indexPath.row].name, birthDay: dateToString(date: awaitedCats[indexPath.row].birthDate), arriveToShelter: dateToString(date: awaitedCats[indexPath.row].arriveToShelter), neuteringDate: dateToString(date: awaitedCats[indexPath.row].neuteringDate),gender: awaitedCats[indexPath.row].gender)
        return cell
    }
    
    func dateToString(date:NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd."
        return formatter.string(from: date as Date)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            OperationQueue.main.addOperation { () -> Void in
                let realm = try! Realm()
                try! realm.write({
                    let model = realm.objects(Cat.self).first(where: {value -> Bool in value.id == self.awaitedCats[indexPath.row].id})
                    realm.delete(model!)
                })
                self.awaitedCats.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title:"Adoption",message: "Adopt "+awaitedCats[indexPath.row].name+"?",preferredStyle: .alert)
               alert.addTextField{(textField) in
                   textField.placeholder = "New Owner's Name"
               }
               alert.addAction(UIAlertAction(title: "Mark as adopted", style: .default, handler: { [weak alert] (_) in
                   guard let textField = alert?.textFields?[0], let newOwnerName = textField.text else {return}
                    print("New Owner \(newOwnerName)")
               
                
                               
                /*try! self.realm.write({
                    self.awaitedCats[indexPath.row].ownerName = newOwnerName
                   self.awaitedCats[indexPath.row].adoptionDate = NSDate()
                    self.catToAdopt = self.awaitedCats[indexPath.row]
                    try! self.realm.commitWrite()
                })*/
                
                //let cat=self.awaitedCats[indexPath.row]
                //var catToDelete = self.realm.objects(Cat.self)
                //let dbProduct=self.realm.object(ofType: Cat.self, forPrimaryKey: self.awaitedCats[indexPath.row].name)
                self.catToAdopt = Cat(value: self.awaitedCats[indexPath.row]) // deepcopy
                self.catToAdopt!.ownerName = newOwnerName
                self.catToAdopt!.adoptionDate = NSDate()
                self.catToAdopt!.adopted = true
                
                OperationQueue.main.addOperation { () -> Void in
                    let realm = try! Realm()
                    try! realm.write({
                        //let id = self.awaitedCats[indexPath.row].id
                        //tableView.reloadData()
                        /*var v = self.realm.objects(Cat.self).first(where: {value -> Bool in value.name == self.awaitedCats[indexPath.row].name})!
                        print(v.name)*/
                        let model = realm.objects(Cat.self).first(where: {value -> Bool in value.id == self.awaitedCats[indexPath.row].id})
                        realm.delete(model!)
                        //try! self.realm.commitWrite()
                        //self.awaitedCats.remove(at: indexPath.row)
                    })
                    self.awaitedCats.remove(at: indexPath.row)
                    tableView.reloadData()
                    
                }
                /*OperationQueue.main.addOperation { () -> Void in
                    self.awaitedCats[indexPath.row].ownerName = newOwnerName
                    self.awaitedCats[indexPath.row].adoptionDate = NSDate()
                    self.catToAdopt = self.awaitedCats[indexPath.row]
                }*/
                
                
                
        
                tableView.reloadData()
                self.performSegue(withIdentifier: "addAdoption", sender: self)
                
                
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
                guard let textField = alert?.textFields?[0], let _ = textField.text else {return}
                          print("Cancelled")
                      }))
               self.present(alert,animated:true,completion:nil)
    }
    @IBAction func cancel(seuge:UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addAdoption"){
            let vc = segue.destination as! adoptedCatsViewController
            vc.newAdoptedCat = self.catToAdopt
        }

        
    }
    @IBAction func done(seuge:UIStoryboardSegue) {
        print("ASD");
        let addCatVC = seuge.source as! addCatViewController
        let newCat=addCatVC.newCat!
        print(newCat.birthDate)
        print(newCat.arriveToShelter)
        print(newCat.neuteringDate)
        realm.beginWrite()
        realm.add(newCat)
        try! realm.commitWrite()
        awaitedCats.append(newCat)
        upForAdoptionTableView.reloadData()
    }
}
