//
//  DetailViewController.swift
//  TestTaskCP
//
//  Created by VLAD on 15/06/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    @IBOutlet weak var hotelImage: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var hotelModel : HotelModel!
    
    func model(model: HotelModel) {
        hotelModel = model
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Информация об отеле"
        
        
        setDefaults()
        getPhoto()
        
         
        activityIndicator.startAnimating()
        
    }
    
  
    
    func setDefaults() {
        
        addressLabel.text = hotelModel.address
        nameLabel.text = hotelModel.name
        starsLabel.text = "\(hotelModel.stars)"
        distanceLabel.text = "\(hotelModel.distance)"
        availabilityLabel.text = hotelModel.suites_availability
        
        
        availabilityLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
    func getPhoto() {
        
        APIManager.sharedMananger.downloadPhoto(id: hotelModel.image) {[weak self] (image) in
            guard let weakSelf = self else { return }
            
            weakSelf.activityIndicator.stopAnimating()
            weakSelf.activityIndicator.hidesWhenStopped = true
            weakSelf.hotelImage.image = image
        
        }
    }
 
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
