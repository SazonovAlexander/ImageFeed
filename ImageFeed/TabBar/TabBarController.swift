import UIKit


final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


private extension TabBarController {
    
    func setup() {
        setupViewControllers()
        setupApperance()
    }
    
    func setupApperance() {
        self.tabBar.barTintColor = .ypBlack
        self.tabBar.tintColor = .ypWhite
    }
    
    func setupViewControllers() {
        let imagesListPresenter = ImagesListPresenter()
        let imagesListViewController = ImagesListViewController()
        imagesListPresenter.view = imagesListViewController
        imagesListViewController.presenter = imagesListPresenter
        imagesListViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabEditorialActive"),
            selectedImage: nil
        )
        
            
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(logoutHelper: LogoutHelper())
        profilePresenter.view = profileViewController
        profileViewController.presenter = profilePresenter
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabProfileActive"),
            selectedImage: nil
        )
   
           
       self.viewControllers = [imagesListViewController, profileViewController]
    }
    
}
