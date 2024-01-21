import UIKit
import Kingfisher
import WebKit


final class ProfileViewController: UIViewController {
    
    //MARK: - Private properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.profile)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Екатерина Новикова"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        return label
    }()
    
    private lazy var profileLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@ekaterina_nov"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, world!"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.logout, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        return button
    }()
    
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObserver()
    }

}


//MARK: - Private methods
private extension ProfileViewController {
    
    func setupObserver(){
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
    
    func setupView(){
        
        view.backgroundColor = .ypBlack
        updateAvatar()
        addViews()
        addConstraints()
        updateProfileDetails()
        addActions()
    }
    
    func addActions() {
        logoutButton.addTarget(self, action: #selector(Self.didTapLogoutButton), for: .touchUpInside)
    }
    
    func addViews(){
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(profileLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(logoutButton)

    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            profileLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            profileLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    func updateProfileDetails() {
        if let profile = profileService.profile {
            nameLabel.text = profile.name
            profileLabel.text = profile.loginName
            descriptionLabel.text = profile.bio
        }
    }
    
    
    @objc
    func didTapLogoutButton(){
        let alert = UIAlertController(title: "Пока, пока!", message: "Уверены что хотите выйти?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {[weak self] _ in
            guard let self else { return }
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
        present(alert, animated: true)
    }
    
    func logout() {
        OAuth2TokenStorage.shared.accessToken = ""
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
             records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
             }
        }
        switchToSplashScreen()
    }
    
    func switchToSplashScreen() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let splashScreenController = SplashScreenViewController()
           
        window.rootViewController = splashScreenController
    }
    
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        profileImageView.kf.setImage(with: url)
    }
}
