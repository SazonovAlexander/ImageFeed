import UIKit


final class SplashScreenViewController: UIViewController {
    
    private let oAuth2Service: OAuth2Service = OAuth2Service()
    private let authSegueIdentifier = "AuthSegueIdentifier"
    private let tokenStorage = OAuth2TokenStorage()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if tokenStorage.accessToken != nil {
            self.switchToTabBarController()
        } else {
            performSegue(withIdentifier: authSegueIdentifier, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == authSegueIdentifier {
            guard let navigationController = segue.destination as? UINavigationController,
                  let authViewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(authSegueIdentifier)") }
            authViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
           
        window.rootViewController = tabBarController
    }
}

extension SplashScreenViewController: AuthViewControllerDelegate {
    
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true)
        oAuth2Service.fetchAuthToken(code, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.switchToTabBarController()
            case .failure:
                let alert = UIAlertController(title: "Что-то пошло не так(", message: "Не удалось войти в систему", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(alertAction)
                self.present(alert, animated: true)
            }
        })
    }
    
    
}
