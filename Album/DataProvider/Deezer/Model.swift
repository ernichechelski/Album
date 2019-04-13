//
//  Model.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import Foundation
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
