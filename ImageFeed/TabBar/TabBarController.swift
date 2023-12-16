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
            
        let imagesListViewController = ImagesListViewController()
        imagesListViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabEditorialActive"),
            selectedImage: nil
        )
        
            
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabProfileActive"),
            selectedImage: nil
        )
   
           
       self.viewControllers = [imagesListViewController, profileViewController]
    }
    
}
