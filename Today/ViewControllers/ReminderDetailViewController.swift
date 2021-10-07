//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by Kevin Hoàng on 02.10.21.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
    typealias ReminderChangeAction = (Reminder) -> Void
    
    private var reminder: Reminder?
    
    private var tempReminder: Reminder?
    
    private var dataSource: UITableViewDataSource?
    
    private var reminderChangeAction: ReminderChangeAction?
    
    func configure(with reminder: Reminder, changeAction: @escaping ReminderChangeAction) {
        self.reminder = reminder
        self.reminderChangeAction = changeAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditing(false, animated: false)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController,
           !navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let reminder = reminder else { fatalError("No reminder found for detail view") }
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder) { reminder in
                self.tempReminder = reminder
                self.editButtonItem.isEnabled = true
                
            }
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
            navigationItem.title = "Edit Reminder"
        } else {
            if let tempReminder = tempReminder {
                self.reminder = tempReminder
                self.tempReminder = nil
                reminderChangeAction?(tempReminder)
                dataSource = ReminderDetailDataSource(reminder: tempReminder)
            } else {
                dataSource = ReminderDetailDataSource(reminder: reminder)
            }
            navigationItem.leftBarButtonItem = nil
            editButtonItem.isEnabled = true
            navigationItem.title = "View Reminder"
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func cancelButtonTrigger() {
        setEditing(false, animated: true)
    }
}
