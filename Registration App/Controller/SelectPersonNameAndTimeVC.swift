//
//  SelectPersonNameAndTimeVC.swift
//  Registration App
//
//  Created by Mahesh Prasad on 29/04/19.
//  Copyright © 2019 CreatesApps. All rights reserved.
//

import UIKit
import Alamofire

class SelectPersonNameAndTimeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cityTitle:String = ""
    var arrayData = [SelectTagNo]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData(){
        let para: Parameters = ["place":cityTitle.self]
        print(para)
        let url = URL(string: "http://magicconversion.com/barcodescanner/tagdata.php")
        
        Alamofire.request(url!, method: .post, parameters: para, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                break
            case .failure(let error):
                print(error)
            }
        }
        
        
//        Alamofire.request(url!, method: .post, parameters: para, encoding: JSONEn,headers: nil).responseJSON { (response) in
//            if let json = response.result.value as! [String: Any]? {
////                let data: NSArray = json as! NSArray
//                print(json)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
  
}
