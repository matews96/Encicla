//
//  Facade.swift
//  Encicla
//
//  Created by Mateo Echeverri on 11/24/17.
//  Copyright © 2017 Mateo Echeverri. All rights reserved.
//

import Foundation
import Alamofire

class Facade {
    
    static func downloadJson(completionHandler: @escaping ([Station])->Void)->Void {
        
        Alamofire.request("http://www.encicla.gov.co/status").responseJSON { response in

            do {
                let web = try JSONDecoder().decode(WebSite.self, from: response.data!)
                var stations = [Station]()
                for zone in web.stations {
                    stations.append(contentsOf: zone.items)
                }
                print("****************************************************************")
                print(stations)
                 completionHandler(stations)
            } catch let jsonError{
                print(".........................................")
                print(jsonError)
            }
            
        }
    }
}
