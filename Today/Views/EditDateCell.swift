//
//  EditDateCell.swift
//  Today
//
//  Created by Kevin Hoàng on 03.10.21.
//

import UIKit

class EditDateCell: UITableViewCell {
    typealias DateChangeAction = (Date) -> Void
    
    @IBOutlet var datePicker: UIDatePicker!
    
    private var dateChangeAction: DateChangeAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    
    func configure(date: Date, changeAction: @escaping DateChangeAction) {
        datePicker.date = date
        self.dateChangeAction = changeAction
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        dateChangeAction?(sender.date)
    }
}
