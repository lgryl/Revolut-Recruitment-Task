//
//  ConverterDataProvider.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import UIKit

class ConverterDataProvider: NSObject {
    var model = ["EUR", "AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "ISK"]
    
    fileprivate func moveToTheTopModelElement(at index: Int) {
        let element = model.remove(at: index)
        model.insert(element, at: 0)
    }
}

extension ConverterDataProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConverterViewController.cellIdentifier) as? CurrencyCell else {
            fatalError()
        }
        let currencyCode = model[indexPath.row]
        cell.configure(with: currencyCode)
        
        return cell
    }
}

extension ConverterDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        moveToTheTopModelElement(at: indexPath.row)
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.moveRow(at: indexPath, to: firstIndexPath)
        
        tableView.scrollToRow(at: firstIndexPath, at: .top, animated: true)
    }
    
}
