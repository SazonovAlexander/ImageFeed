import Foundation


struct PhotoResult: Decodable {
    let id: String
    let createdAt: Date?
    let likeByUser: Bool
    let width: Int
    let height: Int
    let description: String?
    let urls: UrlsResult
}


enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
    case likeByUser = "like_by_user"
    case width
    case height
    case description
    case urls
}

struct UrlsResult: Decodable {
    let large: String
    let thumb: String
}
