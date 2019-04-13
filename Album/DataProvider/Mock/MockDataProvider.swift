//
//  MockDataProvider.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation
import RxSwift
class MockDataProvider:MySectionDataSource{
    func dataObservable() -> Observable<[MySectionViewModel]> {
        return Observable.create({ (observer) -> Disposable in
            var model = MySectionViewModel(header:"",items:[])
            model.items.append("https://www.wprost.pl/_thumb/f3/b6/94eddf8fb4dfba746b15ce2695ef.jpeg")
            model.items.append("http://www.cotoznaczy.com.pl/wp-content/uploads/2011/12/xd-300x300.png")
            model.items.append("https://i.kym-cdn.com/entries/icons/facebook/000/017/436/XD_Face.jpg")
            model.items.append("https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/718smiley.svg/733px-718smiley.svg.png")
            observer.onNext([model])
            return Disposables.create()
        })
    }
    
    
}
