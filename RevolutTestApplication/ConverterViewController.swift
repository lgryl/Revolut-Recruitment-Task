//
//  ConverterViewController.swift
//  RevolutTestApplication
//
//  Created by lg on 24/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    static let cellIdentifier = "CurrencyCell"
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    private func setupTableView() {
        let cellXib = UINib(nibName: String(describing: CurrencyCell.self), bundle: nil)
        tableView.register(cellXib, forCellReuseIdentifier: ConverterViewController.cellIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
            ])
    }
    
}
