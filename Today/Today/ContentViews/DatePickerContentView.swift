//
//  DatePickerContentView.swift
//  Today
//
//  Created by Ibukunoluwa Akintobi on 30/09/2023.
//

import Foundation
import UIKit


class DatePickerContentView : UIView, UIContentView {
        struct Configuration: UIContentConfiguration {
        var date = Date.now
            /// The closure is defined using the curly braces { }. Inside the closure, _ in is a shorthand for specifying that the closure doesn't use the parameter (in this case, the Date parameter). It essentially means "ignore the argument."
            var onChange:(Date) -> Void = { _ in }
        
            func makeContentView() -> UIView & UIContentView {
                return DatePickerContentView(self)
            }
        }
        let datePicker = UIDatePicker()
        var configuration: UIContentConfiguration {
            didSet {
                configure(configuration:configuration)
            }
        }
        init(_ configuration: UIContentConfiguration) {
            self.configuration = configuration
            super.init(frame: .zero)
            addPinnedSubview(datePicker)
            ///By adding a target and action to this view, the view calls the target’s didPick(_:) selector whenever the date changes.
            datePicker.addTarget(self, action: #selector(didPick(_:)), for: .valueChanged)
            datePicker.preferredDatePickerStyle = .inline
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        datePicker.date = configuration.date
    }
    
    @objc private func didPick(_ sender:UIDatePicker) {
        guard let configuration = configuration as? DatePickerContentView.Configuration else { return }
        configuration.onChange(sender.date)
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
