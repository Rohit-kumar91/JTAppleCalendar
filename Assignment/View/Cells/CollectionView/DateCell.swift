//
//  DateCell.swift
//  Assignment
//
//  Created by Rohit Prajapati on 01/10/20.
//

import UIKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    
    //MARK:- Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    
    //MARK:- Properties
    weak var delegate: CalendarSelectedDateDelegate? = nil
    
    
    override func awakeFromNib() {
        selectedView.layer.cornerRadius = 14
        v1.layer.cornerRadius = 3
        v2.layer.cornerRadius = 3
        v3.layer.cornerRadius = 3
    }
    
    /// This function is used to configure the display cell on calender
    /// It also handle the basic conditions
    /// - Parameters:
    ///     - cellState: The CellSate for getting the state of selected cell.
    func configureCell(cellState: CellState) {
        dateLabel.text = cellState.text
        
        if self.isSelected {
            if cellState.dateBelongsTo == .thisMonth {
                self.dateLabel.textColor = UIColor.white
                self.selectedView.isHidden = false
                let dateString = Utils.dateFormatter.string(from: cellState.date)
                self.delegate?.selectedDate(date: dateString)
            }
            
        } else {
            self.selectedView.isHidden = true
            handleCellTextColor(cellState: cellState)
        }
        
        handleCellEvents(cellState: cellState)
        
    }
    
    
    /// This function use to handle the text color.
    /// - Parameters:
    ///     - cellState: Current Cell State.
    func handleCellTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            self.dateLabel.textColor = UIColor.black
        } else {
            self.dateLabel.textColor = UIColor.lightGray
        }
    }
    
    
    /// This function use to display the duties dots on calandar.
    /// - Parameters:
    ///     - cellState: Current Cell State.
    func handleCellEvents(cellState: CellState) {
        let dateString = Utils.dateFormatter.string(from: cellState.date)
        let dutyDatesArray = DutyList.duties?.filter { $0.DutyStartDate?.components(separatedBy: " ").first == dateString}
        
        guard let filterDuties = dutyDatesArray else { return }
        let dutiesArray = filterDuties.sorted(by: {
            ($0.startDate ?? Date()).compare($1.endDate ?? Date()) == .orderedDescending
        })
        
        for (index, duties) in dutiesArray.enumerated() {
            if index == 3 {
                break
            } else {
                switch index {
                case 0:
                    self.v1.isHidden = false
                    self.v1.backgroundColor = Utils.urgencyColor(urgencyType: duties.Urgency?.lowercased() ?? "")
                    break
                case 1:
                    self.v2.isHidden = false
                    self.v2.backgroundColor = Utils.urgencyColor(urgencyType: duties.Urgency?.lowercased() ?? "")
                    break
                    
                default:
                    self.v3.isHidden = false
                    self.v3.backgroundColor = Utils.urgencyColor(urgencyType: duties.Urgency?.lowercased() ?? "")
                }
            }
        }
    }
}
