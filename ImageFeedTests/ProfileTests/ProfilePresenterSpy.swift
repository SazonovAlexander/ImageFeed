import ImageFeed
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var updateProfileDetailsCalled: Bool = false
    var view: ProfileViewControllerProtocol?
    
    func updateProfileDetails() {
        updateProfileDetailsCalled = true
    }
    
    func logout() {
    }
    
    func updateAvatar() {
    }
    
}
