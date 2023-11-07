//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 16/09/2023.
//

import Foundation
import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
    @objc func didPressButton(_ sender: UIBarButtonItem) {
        let reminder = Reminder(title: "", dueDate: Date.now)
        let viewController = ReminderViewController(reminder: reminder) {
            [weak self] reminder in
            self?.addReminder(reminder)
            self?.updateSnapshot()
            self?.dismiss(animated: true)
        }
        viewController.isAddingReminder = true
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel, target: self, action:#selector(didCancelAdd(_:)))
        viewController.navigationItem.title = NSLocalizedString("Add Reminder", comment: "Add Reminder view controller")
        let navigationController = UINavigationController(rootViewController: viewController)
        ///this method allows you to present a view controller modally 
        present(navigationController,animated: true)
    }
    
    @objc func didCancelAdd(_ sender:UIBarButtonItem) {
        dismiss(animated: true)
    }
    @objc func didChangeListStyle(_ sender:UISegmentedControl) {
        listStyle = ReminderListStyle(rawValue: sender.selectedSegmentIndex) ?? .today
        updateSnapshot()
        refreshBackground()
    }
}

