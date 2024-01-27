import UIKit
import ProgressHUD


final class SplashScreenViewController: UIViewController {
    
    //MARK: - Private properties
    private let oAuth2Service: OAuth2Service = OAuth2Service.shared
    private let authSegueIdentifier = "AuthSegueIdentifier"
    private let tokenStorage = OAuth2TokenStorage.shared
    private let profileService = ProfileService.shared
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LaunchScreen"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - Override methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !tokenStorage.accessToken.isEmpty {
            self.fetchProfile(token: tokenStorage.accessToken)
        } else {
            switchToAuthViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


//MARK: - Private methods
private extension SplashScreenViewController {
    
    func setupView() {
        view.backgroundColor = .ypBlack
        addSubviews()
        activateConstraints()
    }
    
    func addSubviews() {
        view.addSubview(imageView)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let tabBarController = TabBarController()
           
        window.rootViewController = tabBarController
    }
    
    func switchToAuthViewController() {
        let authViewController = AuthViewController()
        authViewController.delegate = self
        let navAuthController = UINavigationController(rootViewController: authViewController)
        navAuthController.modalPresentationStyle = .fullScreen
        navAuthController.navigationBar.isHidden = true
        present(navAuthController, animated: true)
    }
    
}


//MARK: - AuthViewControllerDelegate
extension SplashScreenViewController: AuthViewControllerDelegate {
    
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true)
        UIBlockingProgressHUD.show()
        oAuth2Service.fetchAuthToken(code, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.fetchProfile(token: self.tokenStorage.accessToken)
            case .failure:
                let alert = UIAlertController(title: "Что-то пошло не так(", message: "Не удалось войти в систему", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(alertAction)
                self.present(alert, animated: true)
            }
        })
    }
    
    func fetchProfile(token: String) {
        profileService.fetchProfile(token, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                self.switchToTabBarController()
                ProfileImageService.shared.fetchProfileImageURL(token ,username: profile.username) { _ in }
                UIBlockingProgressHUD.dismiss()
            case .failure(_):
                self.switchToAuthViewController()
                UIBlockingProgressHUD.dismiss()
            }
        })
    }
    
    
}
