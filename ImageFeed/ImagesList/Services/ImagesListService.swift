import Foundation


final class ImagesListService {
    
    private (set) var photos: [Photo] = []
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    private var lastLoadedPage: Int?
    private let urlSession = URLSession.shared
    private var lastTask: URLSessionTask?
    
    
    func fetchPhotosNextPage(_ token: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        if lastTask == nil {
            let nextPage = lastLoadedPage == nil
            ? 1
            : lastLoadedPage! + 1
            let request = imagesListRequest(token: token, page: nextPage)
            let task = urlSession.objectTask(for: request, completion: {[weak self] (result: Result<[PhotoResult], Error>) in
                guard let self else { return }
                switch result {
                case .success(let photoResult):
                    photos.append(contentsOf: photoResult.map({Photo(photo: $0)}))
                    self.lastLoadedPage = nextPage
                    self.lastTask = nil
                    completion(.success(photos))
                    NotificationCenter.default
                        .post(
                            name: ImagesListService.DidChangeNotification,
                            object: self,
                            userInfo: ["Photos": photos])
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            lastTask = task
            task.resume()
        }
    }
    
    func changeLike(_ token: String ,photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
            let request = changeLikeRequest(token: token, photoId: photoId, isLike: isLike)
            let task = urlSession.objectTask(for: request, completion: {[weak self] (result: Result<LikePhotoResult, Error>) in
                guard let self else { return }
                switch result {
                case .success(let photoResult):
                    if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                        photos[index] = Photo(photo: photoResult.photo)
                    }
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            task.resume()
        
    }
    
}


private extension ImagesListService {
    func imagesListRequest(token: String, page: Int) -> URLRequest {
        var request = URLRequest.makeHTTPRequest(
            path: "/photos?page=\(page)",
            httpMethod: "GET",
            baseURL: DefaultBaseURL
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func changeLikeRequest(token: String, photoId: String, isLike: Bool) -> URLRequest {
        var request = URLRequest.makeHTTPRequest(
            path: "/photos/\(photoId)/like",
            httpMethod: isLike ? "DELETE" : "POST" ,
            baseURL: DefaultBaseURL
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
}
