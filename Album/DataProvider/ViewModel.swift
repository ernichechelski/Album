//
//  ViewModel.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift



struct MySectionViewModel {
    var header: String
    var items: [Item]
}

extension MySectionViewModel : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: MySectionViewModel, items: [Item]) {
        self = original
        self.items = items
    }
}
