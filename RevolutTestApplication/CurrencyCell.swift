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
    
    static let amountValidator = AmountValidator()
    static let amountCompleter = AmountCompleter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        amountTextField.keyboardType = .decimalPad
        amountTextField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagImageView.layer.cornerRadius = flagImageView.bounds.width / 2
    }
    
    func configure(with currencyCode: String) {
        amountTextField.isUserInteractionEnabled = false
        
        symbolLabel.text = currencyCode
        
        let flagImage = UIImage(named: "eu")
        flagImageView.image = flagImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            amountTextField.isUserInteractionEnabled = true
            amountTextField.becomeFirstResponder()
        }
    }
    
}

extension CurrencyCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let range = Range(range, in: text) else {
            return false
        }
        let newString = text.replacingCharacters(in: range, with: string)
        let valid = CurrencyCell.amountValidator.isValid(newString)
        
        return valid
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = CurrencyCell.amountCompleter.complete(textField.text)
        amountTextField.isUserInteractionEnabled = false
    }
    
}
