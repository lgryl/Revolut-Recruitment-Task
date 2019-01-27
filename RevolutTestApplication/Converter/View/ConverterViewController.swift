//
//  ConverterViewController.swift
//  RevolutTestApplication
//
//  Created by lg on 24/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import UIKit

protocol ConverterDisplayable: class {
    
}

class ConverterViewController: UIViewController, ConverterDisplayable {
    
    static let cellIdentifier = "CurrencyCell"
    static let rowHeight: CGFloat = 60.0
    
    let tableView = UITableView()
    
    let dataProvider: ConverterDataProvider
    let presenter: ConverterPresenter
    
    init(presenter: ConverterPresenter) {
        self.presenter = presenter
        self.dataProvider = presenter.dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You shouldn't use Storyboard to create this class.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    private func setupTableView() {
        dataProvider.tableView = tableView
        tableView.delegate = dataProvider
        tableView.dataSource = dataProvider
        
        tableView.separatorStyle = .none
        tableView.rowHeight = ConverterViewController.rowHeight
        tableView.estimatedRowHeight = ConverterViewController.rowHeight
        
        let cellXib = UINib(nibName: String(describing: CurrencyCell.self), bundle: nil)
        tableView.register(cellXib, forCellReuseIdentifier: ConverterViewController.cellIdentifier)
        
        addTableViewAsSubview()
    }
}
