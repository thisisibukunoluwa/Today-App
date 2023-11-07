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
    var listStyle : ReminderListStyle = .today
    var filteredReminders:[Reminder] {
        return reminders.filter {
            listStyle.shouldInclude(date: $0.dueDate)
        }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
    let listStyleSegmentedControl = UISegmentedControl(items: [
        ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
    ])
    
    var headerView : ProgressHeaderView?
    var progress : CGFloat {
        let chunkSize = 1.0 / CGFloat(filteredReminders.count)
        let progress = filteredReminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunkSize : 0
            return $0 + chunk
        }
        return progress
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .todayGradientFutureBegin
        
        let listLayout = listLayout()
        
        collectionView.collectionViewLayout = listLayout
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView:UICollectionView, indexPath:IndexPath,itemIdentifier:Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(
            elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler
        )
        
        dataSource.supplementaryViewProvider = {
            supplementaryView, elementKind, indexPath
            in return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(didPressButton(_:))
        )
        addButton.accessibilityLabel = NSLocalizedString("Add Reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        updateSnapshot()
    }
  
    /// is an override of a UICollectionViewDelegate method. This method is called when a user taps on an item (cell) in the collection view and determines whether the item should be selectable or not.We are using it to handle the navigation to a detail view when a collection view item is tapped, but we are intentionally preventing the item from staying selected or highlighted in the collection view
    override func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filteredReminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshBackground()
    }
    override func collectionView(_ collectionView:UICollectionView,willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind:String, at indexPath: IndexPath) {
        guard elementKind == ProgressHeaderView.elementKind,
            let progressView = view as? ProgressHeaderView
        else {
            return
        }
        progressView.progress = progress 
    }
    
    func refreshBackground(){
        collectionView.backgroundView = nil
        let backgroundView = UIView()
        let gradientLayer = CAGradientLayer.gradientLayer(for:listStyle, in: collectionView.frame)
        backgroundView.layer.addSublayer(gradientLayer)
        collectionView.backgroundView = backgroundView
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
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func makeSwipeActions(for indexPath:IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction =  UIContextualAction(style: .destructive, title: deleteActionTitle) {
            [weak self] _, _, completion in
            self?.deleteReminder(withId: id)
            self?.updateSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func supplementaryRegistrationHandler(
        progressView:ProgressHeaderView, elementKind:String, indexPath:IndexPath
    ) {
        headerView = progressView
    }
}


