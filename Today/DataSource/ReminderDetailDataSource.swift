//
//  ReminderDetailDataSource.swift
//  Today
//
//  Created by Kevin Hoàng on 03.10.21.
//

import UIKit

class ReminderDetailDataSource: NSObject {
    enum ReminderRow: Int, CaseIterable {
        case title
        case date
        case time
        case notes
        
        static let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            return formatter
        }()
        
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            return formatter
        }()
        
        func displayText(for reminder: Reminder?) -> String? {
            switch self {
            case .title:
                return reminder?.title
            case .date:
                guard let date = reminder?.dueDate else {
                    return nil
                }
                return Self.dateFormatter.string(from: date)
            case .time:
                guard let date = reminder?.dueDate else {
                    return nil
                }
                return Self.timeFormatter.string(from: date)
            case .notes:
                return reminder?.notes
            }
        }
        
        var cellImage: UIImage? {
            switch self {
            case .title:
                return nil
            case .date:
                return UIImage(systemName: "calendar.circle")
            case .time:
                return UIImage(systemName: "clock")
            case .notes:
                return UIImage(systemName: "square.and.pencil")
            }
        }
    }
    
    var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
        super.init()
    }
}

extension ReminderDetailDataSource: UITableViewDataSource {
    static let reminderDetailCellIdentifier = "ReminderDetailCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderDetailCellIdentifier, for: indexPath)
        let row = ReminderRow(rawValue: indexPath.row)
        cell.textLabel?.text = row?.displayText(for: reminder)
        cell.imageView?.image = row?.cellImage
        return cell
    }
}
