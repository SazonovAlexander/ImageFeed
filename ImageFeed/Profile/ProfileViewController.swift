import UIKit


final class ProfileViewController: UIViewController {
    
    //MARK: - Private properties
    private var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.profile)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Екатерина Новикова"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        return label
    }()
    
    private var profileLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@ekaterina_nov"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, world!"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private var logoutButton: UIButton = {
        let button = UIButton.systemButton(with: UIImage.logout, target: ProfileViewController.self, action: #selector(Self.didTapLogoutButton) )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        return button
    }()
    
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}


//MARK: - Private methods
private extension ProfileViewController {
    
    func setupView(){
        
        view.backgroundColor = .ypBlack
        addViews()
        addConstraints()
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
    
    
    @objc
    func didTapLogoutButton(){
        
    }
}
