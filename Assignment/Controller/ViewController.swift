//
//  ViewController.swift
//  Assignment
//
//  Created by Rohit Prajapati on 01/10/20.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var dutiesTableview: UITableView!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK:- Properties
    var numberOfRows = 6
    var dutiesArray = [DutyList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    @IBAction func commonActions(_ sender: UIButton) {
        switch sender {
        case prevBtn:
            calendarView.scrollToSegment(.previous)
            break
        case nextBtn:
            calendarView.scrollToSegment(.next)
            break
        default:
            print("can't handle")
        }
    }
    
}


//MARK:- Functions
extension ViewController {
    
    /// Setup calendar as the view is loaded.
    func initialSetup() {
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        
        calendarView.selectDates([Date()])
        calendarView.scrollToDate(Date() , animateScroll: false)
    }
    
}


//MARK:- DataSource
extension ViewController: JTACMonthViewDataSource {
    
    /// This function use to display the duties dots on calandar.
    /// - Parameters:
    ///     - calendar: JTACMonthView.
    /// - returns: returns all the configuration setting of the calander like start and end month
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2020 01 01")!
        let endDate = formatter.date(from: "2020 12 31")!
        
        if numberOfRows == 6 {
            return ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: numberOfRows)
        } else {
            return ConfigurationParameters(startDate: startDate,
                                           endDate: endDate,
                                           numberOfRows: numberOfRows,
                                           generateInDates: .forFirstMonthOnly,
                                           generateOutDates: .off,
                                           hasStrictBoundaries: false)
        }
    }
}

//MARK:- Delegate
extension ViewController: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.delegate = self
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        cell.configureCell(cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        cell.configureCell(cellState: cellState)
         
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DateCell else { return }
        cell.configureCell(cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"

        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }

    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 60)
    }
      
    
}



//MARK:- TableView Delegate And DataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dutiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DutiesTC", for: indexPath) as? DutiesTC
        cell?.duty = dutiesArray[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
}

//MARK:- Custom Delegate
extension ViewController: CalendarSelectedDateDelegate {
    func selectedDate(date: String) {
        let dutyDatesArray = DutyList.duties?.filter { $0.DutyStartDate?.components(separatedBy: " ").first == date}
        guard let selectedDuties = dutyDatesArray else { return }
        
        
        dutiesArray = selectedDuties.sorted(by: {
            $0.startDate!.compare($1.endDate!) == .orderedDescending
        })
        dutiesTableview.reloadData()
    }
}



