import Foundation
import SwiftKeychainWrapper


final class OAuth2TokenStorage {
    
    static let shared = OAuth2TokenStorage()
    
    private static let accessTokenKey = "access_token"
    
    private init() {}
     
    var accessToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: OAuth2TokenStorage.accessTokenKey) ?? ""
        }
        set (newToken){
            let isSuccess = KeychainWrapper.standard.set(newToken, forKey: OAuth2TokenStorage.accessTokenKey)
            guard isSuccess else {
                print("Token writing error")
                return
            }
        }
    }
}
