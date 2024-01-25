import Foundation
import WebKit


public protocol LogoutHelperProtocol {
    func logout()
}

final class LogoutHelper: LogoutHelperProtocol {
    
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
    
    private func switchToSplashScreen() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        let splashScreenController = SplashScreenViewController()
           
        window.rootViewController = splashScreenController
    }
    
}
