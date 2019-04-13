//
//  ViewModel.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation
import RxDataSources

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = Int
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
