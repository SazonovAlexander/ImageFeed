import ImageFeed
import Foundation


final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    var updateGetPhotoCalled: Bool = false
    var view: ImageFeed.ImagesListViewControllerProtocol?
    
    func getPhotos() {
        updateGetPhotoCalled = true
    }
    
    func likePhoto(_ photo: ImageFeed.Photo, completion: @escaping () -> Void) {
        
    }
    
}
