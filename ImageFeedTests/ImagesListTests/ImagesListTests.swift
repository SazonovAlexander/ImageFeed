@testable import ImageFeed
import XCTest


final class ImagesListTests: XCTestCase {
    
    func testViewControllerCallsGetPhotos() {
        let viewController = ImagesListViewController()
        let presenter = ImagesListPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.updateGetPhotoCalled)
    }
    
    
}
