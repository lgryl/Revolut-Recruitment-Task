//
//  ConverterDataProvider.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import UIKit

class ConverterDataProvider: NSObject {
    weak var amountsManager: AmountsManager!
    var lastEditedCurrencyCode = "EUR"
    var tableView: UITableView!
    
    private func reloadAllButSelectedRows(in tableView: UITableView, currentIndexPath: IndexPath) {
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows {
            let indexPathsForAllButSelectedRows = indexPathsForVisibleRows.filter { (indexPath) -> Bool in
                indexPath != currentIndexPath
            }
            tableView.reloadRows(at: indexPathsForAllButSelectedRows, with: .none)
        }
    }
    
    func update() {
        update(exceptionCurrencyCode: lastEditedCurrencyCode)
    }
    
    func update(exceptionCurrencyCode: String) {
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, let exceptionIndex = amountsManager.index(of: exceptionCurrencyCode) {
            let exceptionIndexPath = IndexPath(row: 0, section: 0)
            let indexPathsForAllButSelectedRows = indexPathsForVisibleRows.filter { (indexPath) -> Bool in
                indexPath != exceptionIndexPath
            }
            tableView.reloadRows(at: indexPathsForAllButSelectedRows, with: .none)
        }

    }
    
}

extension ConverterDataProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amountsManager.amountsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConverterViewController.cellIdentifier) as? CurrencyCell else {
            fatalError()
        }
        cell.beginEditAction = { [unowned self] (currencyCode) in
            self.lastEditedCurrencyCode = currencyCode
        }
        cell.valueChangedAction = { [unowned self] (currencyCode, value) in
            self.amountsManager.set(value, for: currencyCode)
            if let currentIndex = self.amountsManager.index(of: currencyCode) {
                let currentIndexPath = IndexPath(row: 0, section: currentIndex)
                self.reloadAllButSelectedRows(in: tableView, currentIndexPath: currentIndexPath)
            }
        }
        
        let amount = amountsManager.amount(at: indexPath.row)
        cell.configure(with: amount)
        
        return cell
    }
}

extension ConverterDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        amountsManager.moveAmountFrom(sourceIndex: indexPath.row, to: 0)
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.moveRow(at: indexPath, to: firstIndexPath)
        
        tableView.scrollToRow(at: firstIndexPath, at: .top, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }
    
}
