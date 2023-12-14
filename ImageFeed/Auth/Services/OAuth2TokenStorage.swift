import Foundation


final class OAuth2TokenStorage {
    
    private let accessTokenKey = "access_token"
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set (newToken){
            UserDefaults.standard.setValue(newToken, forKey: accessTokenKey)
        }
    }
}
