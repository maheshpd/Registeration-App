//
//  ViewController.swift
//  Registration App
//
//  Created by Mahesh Prasad on 13/04/19.
//  Copyright © 2019 CreatesApps. All rights reserved.
//

import UIKit

struct jsonData:Decodable {
    let cityname:String
}



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let url = URL(string: "http://magicconversion.com/barcodescanner/selectcity.php")
    let activityIndicator = UIActivityIndicatorView()
    
    var arrdata = [jsonData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = view.center
        activityIndicator.style = .gray
        activityIndicator.alpha = 0.5
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        getData()
    }

    
    func getData() {
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    self.arrdata = try JSONDecoder().decode([jsonData].self, from: data!)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    
                    }
                }
            }catch {
                print("Error in getting json Data")
            }
        }.resume()
    }
    
    //hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        cell.CityLabel.text = arrdata[indexPath.row].cityname
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName:SelectPersonNameAndTimeVC = self.storyboard?.instantiateViewController(withIdentifier: "selectpersonnameandtime") as! SelectPersonNameAndTimeVC
        cityName.cityTitle = arrdata[indexPath.row].cityname
        self.navigationController?.pushViewController(cityName, animated: true)
    }

}

