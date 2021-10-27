//
//  ViewController.swift
//  poc_app
//
//  Created by wilson on 24/10/21.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    private let manager = LocalStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let logged = manager.readStringFromStorage(key: Constants.IS_LOGGED_IN)
        if logged == Constants.LOGGED {
            self.goToHome()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tfEmail.text = ""
        tfPassword.text = ""
    }
    
    @IBAction func register(_ sender: Any) {
        
        if (tfEmail.text != nil) && tfPassword.text != nil {
            manager.saveToStorage(objectToSave: tfEmail.text!, key: Constants.USERNAME)
            manager.saveToStorage(objectToSave:tfPassword.text!, key:Constants.PASSWORD)
            manager.saveToStorage(objectToSave: Constants.LOGGED, key: Constants.IS_LOGGED_IN)
            goToHome()
        }
        
    }
    @IBAction func login(_ sender: Any) {
        
        let pwd = manager.readStringFromStorage(key: Constants.PASSWORD)
        let usr = manager.readStringFromStorage(key: Constants.USERNAME)
        if tfEmail.text == usr && tfPassword.text == pwd {
            manager.saveToStorage(objectToSave: Constants.LOGGED, key: Constants.IS_LOGGED_IN)
            goToHome()
        } else {
            let alertController = UIAlertController(title: Constants.LOGIN_ERROR_TITLE, message: Constants.LOGIN_ERROR_MESSAGE, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: Constants.LOGIN_ERROR_BUTTON_OK, style: .default)
            alertController.addAction(alertAction)
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    private func goToHome() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

