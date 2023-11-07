//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 13/09/2023.
//

import Foundation
import UIKit

extension ReminderListViewController {
    ///we made aliases for these types names because they are very long and it makes out code easier to read and write
    typealias DataSource = UICollectionViewDiffableDataSource<Int,Reminder.ID>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int,Reminder.ID>
    
    var reminderCompletedValue:String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    
    var reminderNotCompletedValue:String {
        NSLocalizedString("Not Completed", comment: "Reminder not completed value")
    }
    
    func updateSnapshot(reloading idsThatChanged:[Reminder.ID] = []) {
        let ids = idsThatChanged.filter { id in filteredReminders.contains(where: { $0.id == id})}
        var snapshot = SnapShot()
        snapshot.appendSections([0])
//        var reminderTitles = [String]()
//        for reminder in Reminder.sampleData {
//            reminderTitles.append(reminder.title)
//        }
//        snapshot.appendItems(reminderTitles)
        snapshot.appendItems(filteredReminders.map{ $0.id})
        
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
        headerView?.progress = progress 
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath:IndexPath, id:Reminder.ID){
        
        let reminder = reminder(withId: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [ doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed:.always)
        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
        
    }
    /// accepts a reminder id and returns the contents of the array element at the specified index
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    /// accepts a reminder and updates the corresponding array element with the contents of the reminder
    func updateReminder(_ reminder:Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    /// accepts a reminder and completes the reminder by toggling the isComplete property
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    func addReminder(_ reminder:Reminder) {
        reminders.append(reminder)
    }
    
    func deleteReminder(withId id :Reminder.ID) {
        let index = reminders.indexOfReminder(withId: id)
        reminders.remove(at: index)
    }
    private func doneButtonAccessibilityAction(for reminder:Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle Completion",comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) {
            [weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        return action
    }
    private func doneButtonConfiguration(  for reminder:Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        
        let button = ReminderDoneButton()
        
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for:.touchUpInside)
        
        button.id = reminder.id
        
        button.setImage(image, for:.normal)
        
        return UICellAccessory.CustomViewConfiguration(customView:button , placement: .leading(displayed:.always))
    }
}


/// Data source behaviours are in this file 

