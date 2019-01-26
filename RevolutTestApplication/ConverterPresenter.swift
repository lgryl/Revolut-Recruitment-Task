//
//  ConverterPresenter.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class ConverterPresenter {
    weak var viewController: ConverterDisplayable!
    let dataProvider: ConverterDataProvider
    
    init(dataProvider: ConverterDataProvider) {
        self.dataProvider = dataProvider
    }
    
}
