import UIKit


final class AuthViewController: UIViewController {
    
    weak var delegate: AuthViewControllerDelegate?
    
    
    //MARK: - Private properties
    private lazy var authScreen: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AuthScreen"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.ypBlack, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .ypWhite
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    
    
    //MARK: - Ovveride methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
      
}


//MARK: - Private methods
private extension AuthViewController {
    
    func setupView() {
        
        view.backgroundColor = .ypBlack
        
        addSubviews()
        activateConstraints()
        addActions()
        
    }
    
    func addSubviews() {
        
        view.addSubview(authScreen)
        view.addSubview(authButton)
        
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            authScreen.widthAnchor.constraint(equalToConstant: 60),
            authScreen.heightAnchor.constraint(equalToConstant: 60),
            authButton.heightAnchor.constraint(equalToConstant: 48),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: authButton.trailingAnchor, constant: 16),
            authScreen.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            authScreen.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            authButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            authButton.topAnchor.constraint(equalTo: authScreen.bottomAnchor, constant: 300)
        ])
    }
    
    func addActions() {
        authButton.addTarget(self, action: #selector(Self.didTapAuthButton), for: .touchUpInside)
    }
    
    @objc
    func didTapAuthButton() {
        let webViewViewController = WebViewViewController()
        let authHelper = AuthHelper()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        webViewViewController.delegate = self
        webViewViewController.presenter = webViewPresenter
        webViewPresenter.view = webViewViewController
        navigationController?.pushViewController(webViewViewController, animated: true)
    }
}

//MARK: - WebViewViewControllerDelegate
extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
    
    
}
