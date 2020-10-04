//
//  DutiesModel.swift
//  Assignment
//
//  Created by Rohit Prajapati on 01/10/20.
//

import Foundation

struct DutiesResponse: Decodable {
    let DutyList: [DutyList]?
}

struct DutyList: Decodable {
    var DutyID: Int?
    var Urgency: String?
    var Subject: String?
    var Message: String?
    var DutyStartDate: String?
    var DutyEndDate: String?
    var dutyStatus: String?
    var DutyAssignment: DutyAssignmentData?
    var CoachORStaffRecieverID: String?
    var MultiDay: String?
    var Until: String?
    
    var assignedMembers: String? {
       
        var localString =  String()
        guard let assignMember = DutyAssignment?.AssignedTo?.Cstb else { return ""}
        for member in assignMember {
            if localString == "" {
                localString = member.Name ?? ""
            } else {
                localString = localString + "," + member.Name! 
            }
        }
        return localString
    }
    

    var startDate: Date? {
        return DutyStartDate?.getDateFromString()
    }
    
    var endDate: Date? {
        return DutyEndDate?.getDateFromString()
    }
    
    var formatedTime: String? {
        return "\(DutyStartDate?.getTimeFromDateTime() ?? "") - \(DutyEndDate?.getTimeFromDateTime() ?? "")"
    }
    
}


struct DutyAssignmentData: Decodable {
    var AssignedTo: AssignedToData?
}

struct AssignedToData: Decodable {
    var Cstb: [CstbListData]?
}


struct CstbListData: Decodable {
    var DutyStatus: String?
    var Name: String?
}



