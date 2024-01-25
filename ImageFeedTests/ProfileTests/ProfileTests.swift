@testable import ImageFeed
import XCTest


final class ProfileTests: XCTestCase {
    
    func testViewControllerCallsUpdateProfileDetailes() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.updateProfileDetailsCalled)
    }
    
    
    func testSwitchToSplashScreen() {
        let logoutHelper = LogoutHelper()
        let presenter = ProfilePresenter(logoutHelper: logoutHelper)
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        presenter.logout()
    
        XCTAssert(window.rootViewController is SplashScreenViewController)
    }
    
}
