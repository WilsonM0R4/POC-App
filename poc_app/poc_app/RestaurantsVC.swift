//
//  RestaurantsVC.swift
//  poc_app
//
//  Created by wilson on 24/10/21.
//

import UIKit

class RestaurantsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    private var restaurants : [Restaurant] = []
    private let storage = LocalStorage()
    private var resArray : [Any] = []
    private var arrPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RestaurantTVC", bundle: nil), forCellReuseIdentifier: "RestaurantTVC")
        prevBtn.isEnabled = false
        nextBtn.isEnabled = false
        
        nextBtn.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        prevBtn.addTarget(self, action: #selector(prevPressed), for: .touchUpInside)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func nextPressed() {
        arrPos += 1
        if resArray.count > 0 && arrPos < resArray.count {
            self.restaurants = self.resArray[arrPos] as! [Restaurant]
        } else {
            arrPos = resArray.count - 1
        }
        self.enablePagBtns()
        self.tableView.reloadData()
    }
    
    @objc func prevPressed() {
        arrPos -= 1
        if resArray.count > 0 && arrPos >= 0 {
            self.restaurants = self.resArray[arrPos] as! [Restaurant]
        } else {
            arrPos = 0
        }
        self.enablePagBtns()
        self.tableView.reloadData()
    }
    
    func enablePagBtns() {
        self.nextBtn.isEnabled = arrPos < resArray.count - 1
        self.prevBtn.isEnabled = arrPos > 0
    }
    
    func setRestaurants(data : [Restaurant]){
        self.resArray = Miscelaneous.splitArray(splitLenght: 20, arrayToSplit: data)
        self.restaurants = self.resArray[0] as! [Restaurant]
        self.tableView.reloadData()
        self.nextBtn.isEnabled = true
    }

    func saveFavorite(restaurant:String) {
        let storage = LocalStorage()
        var favs = self.getFavorites()
        favs.append(restaurant)
        storage.saveToStorage(objectToSave: favs, key: Constants.FAVORITES)
    }
    
    func removeFavorite(restaurant:String) {
        let storage = LocalStorage()
        var favs = self.getFavorites()
        var c = 0
        while c < favs.count {
            let item = favs[c]
            if item == restaurant {
                favs.remove(at: c)
                storage.saveToStorage(objectToSave: favs, key: "favorites")
                break
            }
            c += 1
        }
    }
    
    func checkFavorite(restaurant:String) -> Bool{
        let favs = self.getFavorites()
        for fav in favs {
            if fav == restaurant {
                return true
            }
        }
        
        return false
    }
    
    private func getFavorites() -> [String] {
        return storage.readArrayFromStorage(key: Constants.FAVORITES) as! [String]
    }
    
}

extension RestaurantsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTVC") as! RestaurantTVC
        let imgurl = URL(string: restaurants[indexPath.row].image)!
        let data = try? Data(contentsOf: imgurl)
        cell.cellImage.image = UIImage(data: (data)!)
        cell.cellTitle.text = restaurants[indexPath.row].businessName
        if checkFavorite(restaurant: restaurants[indexPath.row].businessName) {
            cell.favImage.image = UIImage.init(systemName: "star.fill")
        } else {
            cell.favImage.image = UIImage.init(systemName: "star")
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected")
        let detvc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        let imgurl = URL(string: restaurants[indexPath.row].image)!
        let data = try? Data(contentsOf: imgurl)
        detvc.image = UIImage(data:data!)
        detvc.businessName = restaurants[indexPath.row].businessName
        detvc.address = restaurants[indexPath.row].address
        detvc.email = restaurants[indexPath.row].website
        detvc.phone = restaurants[indexPath.row].phone
        self.navigationController?.present(detvc, animated: true, completion: nil)
    }
    
    
}

extension RestaurantsVC : RestaurantCellDelegate {
    
    func favIconPressed(tableViewCell: RestaurantTVC, favorite:Bool) {
        let index = tableView.indexPath(for: tableViewCell)!.row
        let restaurant = restaurants[index].businessName
        if favorite {
            self.saveFavorite(restaurant: restaurant)
        } else {
            self.removeFavorite(restaurant: restaurant)
        }
        
    }
    
}
