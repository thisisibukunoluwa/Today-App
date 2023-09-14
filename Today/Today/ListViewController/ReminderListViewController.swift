//
//  ViewController.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 08/09/2023.
//

import UIKit
import Foundation

class ReminderListViewController: UICollectionViewController {
    
    ///we made aliases for these types names because they are very long and it makes out code easier to read and write 
    typealias DataSource = UICollectionViewDiffableDataSource<Int,String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int,String>
    
    var dataSource : DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, IndexPath:IndexPath,itemIdentifier:String) in
            let reminder = Reminder.sampleData[IndexPath.item]
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
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


