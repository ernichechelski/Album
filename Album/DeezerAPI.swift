//
//  DeezerAPI.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation
import Alamofire
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire
import AlamofireImage



class DeezerAPI {
    func xd(){
        var url = "https://api.deezer.com/playlist/2661417904"
        Alamofire.request(url).responsePlaylist { response in
             if let playlist = response.result.value {
                for song in playlist.tracks.data {
                    
                }
             }
        }
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
          
            print(response.request)
            print(response.response)
        
            if let image = response.result.value {
                print("image downloaded: \(image)")
            }
        }
    }
}


struct Playlist: Codable {
    let id: Int
    let title, description: String
    let duration: Int
    let welcomePublic, isLovedTrack, collaborative: Bool
    let nbTracks, fans: Int
    let link, share, picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let checksum: String
    let tracklist: String
    let creationDate: String
    let creator: Creator
    let type: String
    let tracks: Tracks
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, duration
        case welcomePublic = "public"
        case isLovedTrack = "is_loved_track"
        case collaborative
        case nbTracks = "nb_tracks"
        case fans, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case checksum, tracklist
        case creationDate = "creation_date"
        case creator, type, tracks
    }
}

struct Creator: Codable {
    let id: Int?
    let name: String
    let tracklist: String
    let type: CreatorType
    let link: String?
}

enum CreatorType: String, Codable {
    case artist = "artist"
    case user = "user"
}

struct Tracks: Codable {
    let data: [Song]
    let checksum: String
}

struct Song: Codable {
    let id: Int
    let readable: Bool
    let title, titleShort: String
    let titleVersion: String?
    let link: String
    let duration, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String?
    let timeAdd: Int
    let artist: Creator
    let album: Album
    let type: SongType
    
    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case timeAdd = "time_add"
        case artist, album, type
    }
}

struct Album: Codable {
    let id: Int
    let title: String
    let cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let tracklist: String
    let type: AlbumType
    
    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case tracklist, type
    }
}

enum AlbumType: String, Codable {
    case album = "album"
}

enum SongType: String, Codable {
    case track = "track"
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

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
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
}
