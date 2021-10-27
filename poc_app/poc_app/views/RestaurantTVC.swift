//
//  RestaurantTVC.swift
//  poc_app
//
//  Created by wilson on 24/10/21.
//

import UIKit

protocol RestaurantCellDelegate {
    func favIconPressed(tableViewCell:RestaurantTVC, favorite: Bool)
}

class RestaurantTVC: UITableViewCell {

    var delegate : RestaurantCellDelegate!
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!    
    @IBOutlet weak var favImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(favPressed))
        
        favImage.isUserInteractionEnabled = true
        favImage.addGestureRecognizer(gr)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func favPressed() {
        let isFavorite = favImage.image == UIImage(systemName: "star")
        let image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favImage.image = image
        if let del = delegate {
            del.favIconPressed(tableViewCell: self, favorite: isFavorite)
        }
    }
}
