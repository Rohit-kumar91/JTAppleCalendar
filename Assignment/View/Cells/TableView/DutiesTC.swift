//
//  DutiesTC.swift
//  Assignment
//
//  Created by Rohit Prajapati on 01/10/20.
//

import UIKit

class DutiesTC: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imgDuties: UIImageView!
    @IBOutlet weak var lblDutiesType: UILabel!
    @IBOutlet weak var lblDutiesTime: UILabel!
    @IBOutlet weak var lblDutiesDescription: UILabel!
    @IBOutlet weak var dutyColor: UIView!
    
    var duty: DutyList? {
        didSet {
            lblDutiesType.text = duty?.Subject
            lblDutiesTime.text = duty?.formatedTime
            lblDutiesDescription.text = duty?.assignedMembers
            dutyColor.backgroundColor = Utils.urgencyColor(urgencyType: duty?.Urgency?.lowercased() ?? "")
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgDuties.layer.borderWidth = 1
        imageView?.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
