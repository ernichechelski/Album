//
//  DeezerAPI.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation
import Alamofire
import Foundation
import Alamofire
import AlamofireImage
import RxSwift

protocol MySectionDataSource {
     func dataObservable() -> Observable<[MySectionViewModel]>
}

extension DeezerAPI : MySectionDataSource{
    func dataObservable() -> Observable<[MySectionViewModel]> {
        return songsObservable().map({ (songs) -> [MySectionViewModel] in
            var urls = [String]()
            songs.forEach({ (song) in
                if let url = song.album.coverMedium {
                     urls.append(url)
                }
            })
            var result = MySectionViewModel(header: "Playlist covers", items: urls)
            return [result]
        })
    }
}

class DeezerAPI {
    public static var baseUrl = "https://api.deezer.com"
    func songsObservable()->Observable<[Song]>{
        let endpoint = "/playlist/2661417904"
        return BehaviorSubject.create({ (observer) -> Disposable in
            Alamofire.request("\(DeezerAPI.baseUrl)\(endpoint)")
                .responsePlaylist { response in
                if let playlist = response.result.value {
                    observer.onNext(playlist.tracks.data)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
}



extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try self.newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responsePlaylist(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Playlist>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    
    fileprivate func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    fileprivate func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}
