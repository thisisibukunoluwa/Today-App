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
    typealias DataSource = UICollectionViewDiffableDataSource<Int,String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int,String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath:IndexPath, id:String){
        let reminder = Reminder.sampleData[indexPath.item]
        
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = reminder.title
        
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed:.always)
        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        
        cell.backgroundConfiguration = backgroundConfiguration
        
    }
    
    private func doneButtonConfiguration(  for reminder:Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguraion = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguraion)
        let button = UIButton()
        button.setImage(image, for:.normal)
        return UICellAccessory.CustomViewConfiguration(customView:button , placement: .leading(displayed:.always))
    }
}


/// Data source behaviours are in this file 
