//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 16/09/2023.
//

import Foundation

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}

