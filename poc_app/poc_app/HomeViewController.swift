//
//  HomeViewController.swift
//  poc_app
//
//  Created by wilson on 24/10/21.
//

import UIKit

class HomeViewController: UITabBarController {
    
    var restaurantsVC : RestaurantsVC!
    var favoritesVC : FavoritesVC!
    private var favorites : [String]!
    let manager = LocalStorage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantsVC = storyboard?.instantiateViewController(withIdentifier: "RestaurantsVC") as? RestaurantsVC
        favoritesVC = storyboard?.instantiateViewController(withIdentifier: "FavoritesVC") as? FavoritesVC
        
        let logoutBtn = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain , target: self, action: #selector(logout))
        
        self.viewControllers = [restaurantsVC, favoritesVC]
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = logoutBtn
        self.title = "POC App"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let data = APIData()
        data.delegate = self
        data.getRestaurants()
    }

    @objc func logout (){
        manager.saveToStorage(objectToSave: "logout", key: "isLoggedIn")
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeViewController : APIDataDelegate {
    
    func onTaskFinished(success: Bool, data: [Restaurant]) {
        print(data)        
        self.restaurantsVC.setRestaurants(data: data)
        self.favoritesVC.setRestaurants(data: data)
    }
}
