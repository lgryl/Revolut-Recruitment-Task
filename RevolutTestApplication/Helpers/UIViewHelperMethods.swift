//
//  UIViewHelperMethods.swift
//  RevolutTestApplication
//
//  Created by lg on 27/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewWithoutConstraints(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
