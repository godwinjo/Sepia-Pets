//
//  PetTableViewCell.swift
//  PetList
//
//  Created by Godwin on 26/12/22.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    @IBOutlet weak var labelPetTitle: UILabel!
    @IBOutlet weak var imageViewPet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setValues(petDetails: PetDetails, image: UIImage?) {
        labelPetTitle.text = petDetails.title
        imageViewPet.image = image
    }


}
