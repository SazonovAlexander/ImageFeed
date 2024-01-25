import Foundation


public protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func updateProfileDetails()
    func logout()
    func updateAvatar()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewControllerProtocol?
    
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private var logoutHelper: LogoutHelperProtocol
    
    init(logoutHelper: LogoutHelperProtocol) {
        self.logoutHelper = logoutHelper
        setupObserver()
    }
    
    func updateProfileDetails() {
        if let profile = profileService.profile {
            view?.updateProfileDetails(profile)
        }
    }
    
    private func setupObserver() {
        profileImageServiceObserver = NotificationCenter.default
                   .addObserver(
                       forName: ProfileImageService.DidChangeNotification,
                       object: nil,
                       queue: .main
                   ) { [weak self] _ in
                       guard let self = self else { return }
                       self.updateAvatar()
                   }
    }
    
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        
        view?.updateAvatar(url: url)
    }
    
    func logout() {
        logoutHelper.logout()
    }
    
}
