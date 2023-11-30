import Foundation
import UIKit


final class ProfileViewController: UIViewController {
    
    private var profileImageView: UIImageView?
    private var nameLabel: UILabel?
    private var profileLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var logoutButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        addProfileImage()
        addLabels()
        addLogoutButton()
        
    }
    
    private func addProfileImage(){
        let imageView = UIImageView(image: UIImage.profile)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
        
        profileImageView = imageView
        
    }
    
    private func addLabels(){
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        nameLabel.textColor = .white
        
        let profileLabel = UILabel()
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileLabel.text = "@ekaterina_nov"
        profileLabel.font = UIFont.systemFont(ofSize: 13)
        profileLabel.textColor = .gray
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        
        
        view.addSubview(nameLabel)
        view.addSubview(profileLabel)
        view.addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            profileLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ])
        
        if let profileImageView = profileImageView {
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
                nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor)
            ])
        }
        
        self.nameLabel = nameLabel
        self.profileLabel = profileLabel
        self.descriptionLabel = descriptionLabel
        
    }
    
    private func addLogoutButton(){
        
        let button = UIButton.systemButton(with: UIImage.logout, target: self, action: #selector(Self.didTapLogoutButton) )
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tintColor = .red
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: 44)
        ])
        
        if let profileImageView = profileImageView {
            button.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        }
        
        self.logoutButton = button
    }
    
    @objc
    private func didTapLogoutButton(){
        
    }
}
