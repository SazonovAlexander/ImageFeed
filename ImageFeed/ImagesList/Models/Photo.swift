import Foundation


struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    
    init(photo: PhotoResult) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        id = photo.id
        size = CGSize(width: photo.width, height: photo.height)
        createdAt = dateFormatter.date(from: photo.createdAt)
        welcomeDescription = photo.description
        thumbImageURL = photo.urls.thumb
        largeImageURL = photo.urls.large
        isLiked = photo.likeByUser
    }
}
