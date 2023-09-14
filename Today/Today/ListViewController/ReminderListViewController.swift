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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView:UICollectionView, indexPath:IndexPath,itemIdentifier:String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = SnapShot()
        snapshot.appendSections([0])
//        var reminderTitles = [String]()
//        for reminder in Reminder.sampleData {
//            reminderTitles.append(reminder.title)
//        }
//        snapshot.appendItems(reminderTitles)
        snapshot.appendItems(Reminder.sampleData.map{ $0.title })
        dataSource.apply(snapshot)
        collectionView.dataSource = dataSource
    }
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}


