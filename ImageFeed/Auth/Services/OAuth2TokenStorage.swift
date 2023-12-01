import Foundation


final class OAuth2TokenStorage {
    
    private let accessTokenKey = "access_token"
    
    var accessToken: String? {
        get {
            if let token = UserDefaults.standard.string(forKey: accessTokenKey){
                return token
            }
            return nil
        }
        set (newToken){
            UserDefaults.standard.setValue(newToken, forKey: accessTokenKey)
        }
    }
}
