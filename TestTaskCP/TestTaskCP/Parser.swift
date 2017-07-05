//
//  Parser.swift
//  TestTaskCP
//
//  Created by VLAD on 15/06/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import Foundation


class Parser {
    
    func parse(json: Array<Any>) -> [HotelModel] {
        var hotelArray = [HotelModel]()
        json.forEach { (object) in
            let hotel = object as! Dictionary<String, Any>
            let id =  (hotel["id"] as! NSNumber).intValue
            let name = hotel["name"] as! String
            let address = hotel["address"] as! String
            let stars = (hotel["stars"] as! NSNumber).intValue
            let distance = (hotel["distance"] as! NSNumber).doubleValue
            
            let suites_availability = hotel["suites_availability"] as! String
            let suitesCount = suites_availability.components(separatedBy: ":")
            
            let photo = hotel["image"] as! String
            
            let hotelModel = HotelModel(id: id, name: name, address: address, stars: stars, distance: distance, suites_availability: suites_availability, image: photo, countRooms: suitesCount)
            
            hotelArray.append(hotelModel)
        }
        
        return hotelArray
    }

    
   
}
