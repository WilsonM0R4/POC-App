//
//  APIData.swift
//  poc_app
//
//  Created by wilson on 24/10/21.
//

import Foundation

protocol APIDataDelegate {
    func onTaskFinished(success:Bool, data: [Restaurant])
}

class APIData {
    
    var delegate : APIDataDelegate!
    
    func getRestaurants(){
        makeApiCall()
    }
    
    private func makeApiCall(){
        
        let url = URL(string:"https://foodbukka.herokuapp.com/api/v1/restaurant")!
        let httpTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                self.formatResponse(data: data!)
            }
            
            
        }
        
        httpTask.resume()
        
    }
    
    private func formatResponse(data: Data?) {
        print(String(data: data!, encoding: .utf8)!)
        var result : [Restaurant] = []
        if let d = data {
            
            do {
                let obj = try JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as! [String: Any]
                let arr = obj["Result"] as! [Any]
                for itm in arr {
                    let item = itm as! [String: Any]
                    let restaurant = Restaurant(businessName: item["businessname"] as! String, address: item["address"] as! String, website: item["email"] as! String, phone: item["phone"] as! String, image: item["image"] as! String)
                    result.append(restaurant)
                }
                self.delegate.onTaskFinished(success: true, data: result)
            } catch {
                print(error)
            }
        }
    }
    
}
