import Foundation


public protocol ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func getPhotos()
    func likePhoto(_ photo: Photo, completion: @escaping () -> Void)
}


final class ImagesListPresenter: ImagesListPresenterProtocol {
    
    weak var view: ImagesListViewControllerProtocol?
    private var listImagesServiceObserver: NSObjectProtocol?
    private var imagesListService = ImagesListService()
    
    init() {
        setupObserver()
    }
    
    private func setupObserver(){
        listImagesServiceObserver = NotificationCenter.default
                   .addObserver(
                       forName: ImagesListService.DidChangeNotification,
                       object: nil,
                       queue: .main
                   ) { [weak self] _ in
                       guard let self = self else { return }
                       self.view?.updateTableViewAnimated(newPhotos: imagesListService.photos)
                   }
    }
    
    func getPhotos() {
        imagesListService.fetchPhotosNextPage(OAuth2TokenStorage.shared.accessToken, completion: {_ in})
    }
    
    func likePhoto(_ photo: Photo,completion:@escaping () -> Void) {
        UIBlockingProgressHUD.show()
        imagesListService.changeLike(OAuth2TokenStorage.shared.accessToken, photoId: photo.id, isLike: photo.isLiked, { result in
            switch result {
            case .success(_):
                completion()
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                UIBlockingProgressHUD.dismiss()
            }
        })
    }
    
    
}
