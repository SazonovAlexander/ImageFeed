import Foundation


final class ImagesListService {
    
    
    static let shared = ImagesListService()
    
    private init(){}
    
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
    
}


private extension ImagesListService {
    func imagesListRequest(token: String, page: Int) -> URLRequest {
        var request = URLRequest.makeHTTPRequest(
            path: "/photos?page=/(page)",
            httpMethod: "GET",
            baseURL: DefaultBaseURL
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}
