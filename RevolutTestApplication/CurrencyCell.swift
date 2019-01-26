//
//  CurrencyCell.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagImageView.layer.cornerRadius = flagImageView.bounds.width / 2
    }
    
    func configure(with currencyCode: String) {
        symbolLabel.text = currencyCode
        
        let flagImage = UIImage(named: "eu")
        flagImageView.image = flagImage
    }
    
}
