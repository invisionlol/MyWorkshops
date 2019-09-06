// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let youtubeResponse = try? newJSONDecoder().decode(YoutubeResponse.self, from: jsonData)

import Foundation

// MARK: - YoutubeResponse
struct YoutubeResponse: Codable {
    let youtubes: [Youtube]
    let error: Bool
    let errorMsg: String
    
    enum CodingKeys: String, CodingKey {
        case youtubes, error
        case errorMsg = "error_msg"
    }
}

// MARK: - Youtube
struct Youtube: Codable {
    let id, title, subtitle: String
    let avatarImage: String
    let youtubeImage: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, subtitle
        case avatarImage = "avatar_image"
        case youtubeImage = "youtube_image"
    }
}
