//
//  HotelsTableViewController.swift
//  TestTaskCP
//
//  Created by VLAD on 15/06/2017.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit

class HotelsTableViewController: UITableViewController {

    
    var hotelsArray = [HotelModel]()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        setDefaults()
        getHotels()
        
            
        let backButton = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefaults() {
        
        self.view.backgroundColor = UIColor.white
        self.title = "Отели"
    }
    
    func getHotels() {
        
        APIManager.sharedMananger.downloadHotels { [weak self] (array) in
            guard let weakSelf = self else { return }
    
            weakSelf.hotelsArray = array
            weakSelf.tableView.reloadData()
        }
    }
    
    

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return hotelsArray.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HotelsTableViewCell

        
        cell.configureWithModel(hotelModel: hotelsArray[indexPath.row])
        
        return cell
    }
    

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.model(model: hotelsArray[indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    
    // MARK: - IBActions
    
    @IBAction func sortAction(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Отсортировать отели", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Самый близкий к центру", style: UIAlertActionStyle.default, handler: { action in
        
            self.hotelsArray.sort {
                    return $0.distance < $1.distance
            }
            
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "По свободным номерам", style: UIAlertActionStyle.default, handler: { action in
        
            self.hotelsArray.sort {
                    $0.countRooms.count > $1.countRooms.count
            }
            
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Отменить", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
