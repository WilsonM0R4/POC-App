//
//  DetailVC.swift
//  poc_app
//
//  Created by wilson on 25/10/21.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var lblBusinessName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    var image : UIImage!
    var businessName: String!
    var address: String!
    var email: String!
    var phone: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        lblBusinessName.text = businessName
        lblAddress.text = address
        lblEmail.text = email
        lblPhone.text = phone
        
        lblAddress.numberOfLines = 0
        lblAddress.sizeToFit()
    }
    
}
