//
//  HotelsTableViewCell.swift
//  TestTaskCP
//
//  Created by VLAD on 15/06/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class HotelsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stars: UILabel!

    @IBOutlet weak var view: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view.roundCorners(corners: [.topLeft], radius: 15)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureWithModel(hotelModel : HotelModel)  {
        
    
        address.text = hotelModel.address
        name.text = hotelModel.name
        stars.text = "\(hotelModel.stars)"

    }
 


}
