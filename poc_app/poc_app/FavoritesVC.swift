//
//  FavoritesVC.swift
//  poc_app
//
//  Created by wilson on 25/10/21.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var favTable: UITableView!
    private var favorites : [Restaurant] = []
    private var favs : [String] = []
    private var storage = LocalStorage()
    var restaurants : [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favTable.delegate = self
        favTable.dataSource = self
        favTable.register(UINib(nibName: "RestaurantTVC", bundle: nil), forCellReuseIdentifier: "RestaurantTVC")
        
        self.title = "Favorites"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        extractFavorites()
        favTable.reloadData()
        print("Favs did appear")
    }
    
    func setRestaurants(data : [Restaurant]){
        self.restaurants = data
        extractFavorites()
    }
    
    private func extractFavorites() {
        favs = storage.readArrayFromStorage(key: Constants.FAVORITES) as! [String]
        self.favorites = []
        for fav in favs {
            for item in restaurants {
                if item.businessName == fav {
                    self.favorites.append(item)
                }
            }
        }
    }

}

extension FavoritesVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTVC") as! RestaurantTVC
        let favorite = favorites[indexPath.row]
        let imgurl = URL(string: favorite.image)!
        let data = try? Data(contentsOf: imgurl)
        cell.cellImage.image = UIImage(data: (data)!)
        cell.cellTitle.text = favorite.businessName
        cell.favImage.image = UIImage.init(systemName: "star.fill")
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected")
        let detvc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        let favorite = favorites[indexPath.row]
        let imgurl = URL(string: favorite.image)!
        let data = try? Data(contentsOf: imgurl)
        detvc.image = UIImage(data:data!)
        detvc.businessName = favorite.businessName
        detvc.address = favorite.address
        detvc.email = favorite.website
        detvc.phone = favorite.phone
        self.navigationController?.present(detvc, animated: true, completion: nil)
    }
    
}

extension FavoritesVC : RestaurantCellDelegate {
    
    func favIconPressed(tableViewCell: RestaurantTVC, favorite: Bool) {
        let index = favTable.indexPath(for: tableViewCell)!.row
        self.favorites.remove(at: index)
        self.favs.remove(at: index)
        self.favTable.reloadData()
        storage.saveToStorage(objectToSave: favs, key: Constants.FAVORITES)
        
    }
    
}

