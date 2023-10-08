//
//  ViewController.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 08/09/2023.
//

import UIKit
import Foundation


/// View controller behaviours are in this file
/// Because they have many responsibilities in UIKit apps, view controller files can be large. Reorganizing the view controller responsibilities into separate files and extensions makes it easier to find errors and add new features later.
/// 
class ReminderListViewController: UICollectionViewController {

    var dataSource : DataSource!
    var reminders:[Reminder] = Reminder.sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView:UICollectionView, indexPath:IndexPath,itemIdentifier:Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        updateSnapshot()
    }
  
    /// is an override of a UICollectionViewDelegate method. This method is called when a user taps on an item (cell) in the collection view and determines whether the item should be selectable or not.We are using it to handle the navigation to a detail view when a collection view item is tapped, but we are intentionally preventing the item from staying selected or highlighted in the collection view
    override func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
  
    /// This method is used for navigating from the ReminderListViewController to the DetailView Controller
    func pushDetailViewForReminder(withId id: Reminder.ID) {
        let reminder = reminder(withId:id)
        let viewController = ReminderViewController(reminder: reminder) {
            [weak self] reminder in self?.updateReminder(reminder)
            self?.updateSnapshot(reloading: [reminder.id])
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    ///returns a specific UICollectionViewCompositionalLayout for a UICollectionView. This layout is configured to create a list-like appearance for the collection view.
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}


