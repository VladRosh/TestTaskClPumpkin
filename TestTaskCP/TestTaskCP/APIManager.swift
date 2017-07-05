//
//  APIManager.swift
//  TestTaskCP
//
//  Created by VLAD on 15/06/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
  
    static let baseImageURLString = "https://github.com/iMofas/ios-android-test/raw/master/"
 
    
    static let sharedMananger = APIManager()
    let parser = Parser()
    
    let session : URLSession!
    
    init() {
        session = URLSession.shared
    }
    
    func downloadHotels(completion:@escaping ([HotelModel]) -> ()) {
        
        let file = Bundle.main.path(forResource: "jsons", ofType: "json")
        let url = URL(fileURLWithPath: file!)
        
        let task = session.dataTask(with: url){ (data, response, error) in
            guard error == nil else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                let array = self.parser.parse(json: json)
                DispatchQueue.main.async(execute: {
                    completion(array)
                })
            } catch _ as NSError {}
        }
    
        task.resume()
        
        
    }
    
    func downloadPhoto(id: String, completion:@escaping (UIImage) -> ()) {
        
        let urlString = APIManager.baseImageURLString + id
        let url = URL(string: urlString)


        let task = session.dataTask(with:url!) { (data, response, error) in
            guard error == nil else {
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    completion(image)
                })
             }
            }
            task.resume()
        }
}
