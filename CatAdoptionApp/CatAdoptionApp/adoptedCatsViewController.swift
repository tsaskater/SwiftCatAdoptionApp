//
//  adoptedCatsViewController.swift
//  CatAdoptionApp
//
//  Created by administrator on 2022. 03. 05..
//  Copyright © 2022. administrator. All rights reserved.
//

import UIKit
import RealmSwift

class adoptedCatsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    var newAdoptedCat:Cat?
    let realm = try! Realm()
    
    @IBOutlet weak var adoptedCatsTableView: UITableView!
    var adoptedCats:[Cat] = [Cat(name: "Gézu", birthDate: NSDate() , arriveToShelter: NSDate(), adoptionDate:NSDate(), ownerName: "Roli", neuteringDate: NSDate(),gender:true)]
    override func viewDidLoad() {
        super.viewDidLoad()
        if(newAdoptedCat != nil){
            self.progressIndicator.isHidden = false
            newAdoptedCat!.id = UUID().uuidString // new id needed cause delete is in progress (could've use update)
            realm.beginWrite()
            realm.add(newAdoptedCat!.self)
            try! realm.commitWrite()
            sleep(1)
            self.progressIndicator.isHidden = true
        }
        loadSavedAdoptedCats()
        // Do any additional setup after loading the view.
    }
    
    func loadSavedAdoptedCats(){
    self.progressIndicator.isHidden = false
    var syncCats:[Cat] = []
    /*realm.beginWrite()
    realm.deleteAll()
    try! realm.commitWrite()*/
    let adoptedCats = realm.objects(Cat.self)
    for cat in adoptedCats {
            //print("REALMCAT: \(awaitedCats.count)" + cat.name)
            if cat.adopted{
                syncCats.append(cat)
            }
                
           OperationQueue.main.addOperation { () -> Void in
               self.adoptedCats=[]
               print("SYNC CATS LENGTH: \(syncCats.count)")
               self.adoptedCats = syncCats
               print("awaited CATS LENGTH: \(self.adoptedCats.count)")
               self.adoptedCatsTableView.reloadData()
               sleep(1)
               self.progressIndicator.isHidden = true
           }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete{
               OperationQueue.main.addOperation { () -> Void in
                   let realm = try! Realm()
                   try! realm.write({
                       let model = realm.objects(Cat.self).first(where: {value -> Bool in value.id == self.adoptedCats[indexPath.row].id})
                       realm.delete(model!)
                   })
                   self.adoptedCats.remove(at: indexPath.row)
                   tableView.reloadData()
               }
           }
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(adoptedCats.count)
        return adoptedCats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "catCardAdopt", for: indexPath) as! CatCard
        cell.configure(name: adoptedCats[indexPath.row].name, birthDay: dateToString(date: adoptedCats[indexPath.row].birthDate), arriveToShelter: dateToString(date: adoptedCats[indexPath.row].arriveToShelter), neuteringDate: dateToString(date: adoptedCats[indexPath.row].neuteringDate),adoptedByName: adoptedCats[indexPath.row].ownerName!, adoptionDate: dateToString(date: adoptedCats[indexPath.row].adoptionDate!), gender: adoptedCats[indexPath.row].gender)
           return cell
       }
       
       func dateToString(date:NSDate) -> String{
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy.MM.dd."
           return formatter.string(from: date as Date)
       }
    

}
