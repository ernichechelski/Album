//
//  DataProvider.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation


class DataProvider:NSObject {
    
    let source:MySectionDataSource
    
    override init() {
        self.source = DeezerAPI()
        //self.source = MockDataProvider()
    }
    
    func getSource()->MySectionDataSource{
        return source
    }
    
}
