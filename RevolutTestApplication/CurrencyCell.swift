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
    
    static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        
        
        return numberFormatter
    }()
    
    var currencyCode: String = ""
    var valueChangedAction: ((String, Decimal) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        amountTextField.keyboardType = .decimalPad
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagImageView.layer.cornerRadius = flagImageView.bounds.width / 2
    }
    
    func configure(with amount: Amount) {
        amountTextField.isUserInteractionEnabled = false
        
        currencyCode = amount.currencyCode
        
        let amountString = CurrencyCell.numberFormatter.string(from: NSDecimalNumber(decimal: amount.value))
        amountTextField.text = amountString
        
        symbolLabel.text = amount.currencyCode
        
        
        
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, let value = Decimal(string: text, locale: Locale.current), let valueChangedAction = valueChangedAction {
            
            valueChangedAction(currencyCode, value)
        }
    }
    
}
