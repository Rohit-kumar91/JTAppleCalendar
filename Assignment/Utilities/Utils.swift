//
//  Utils.swift
//  Assignment
//
//  Created by Rohit Prajapati on 01/10/20.
//

import UIKit

class Utils {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
   static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" 
        return dateFormatter
    }()
      
    
    static func urgencyColor(urgencyType: String) -> UIColor {
        switch urgencyType {
        case "v":
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
        case "l":
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        case "s":
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
        case "n":
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
        default:
            return UIColor.clear
        }
    }

}
