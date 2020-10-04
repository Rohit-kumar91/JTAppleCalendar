//
//  Extensions.swift
//  Assignment
//
//  Created by Rohit Prajapati on 03/10/20.
//

import Foundation

extension String {
    
    func getDateFromString() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dateFormatter.date(from:self)
        return date
           
    }
    
    func getTimeFromDateTime() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dateFormatter.date(from:self)
        
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
    }
    
}



