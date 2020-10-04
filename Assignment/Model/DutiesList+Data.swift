//
//  DutiesList+Data.swift
//  Assignment
//
//  Created by Rohit Prajapati on 01/10/20.
//

import Foundation

extension DutyList {
    //V - Red, L - Black, S - Blue, N - White
    static var duties: [DutyList]? {
        let response: DutiesResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "Duties")
        return response?.DutyList
    }
    
    static var urgencyTypeRed: [DutyList]? {
        duties?.filter {$0.Urgency?.lowercased() == "v" }
    }
    
    static var urgencyTypeBlack: [DutyList]? {
        duties?.filter {$0.Urgency?.lowercased() == "L" }
    }
    
    static var urgencyTypeBlue: [DutyList]? {
        duties?.filter {$0.Urgency?.lowercased() == "S" }
    }
    
    static var urgencyTypeWhite: [DutyList]? {
        duties?.filter {$0.Urgency?.lowercased() == "N" }
    }
    
    
    
    
}


extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}

