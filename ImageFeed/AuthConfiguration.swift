import Foundation


let AccessKey = "NadJ-SLpmlAN5HiaSOBOmaSttsyHYbeoiW8MsOtQ968"
let SecretKey = "t-hS0vNcbO5Xy5Av-Oi2_aDODQpmcW08umyvPZFFojw"
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
let AuthUrl = "https://unsplash.com/oauth/authorize"

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    static var standard: AuthConfiguration {
           return AuthConfiguration(accessKey: AccessKey,
                                    secretKey: SecretKey,
                                    redirectURI: RedirectURI,
                                    accessScope: AccessScope,
                                    authURLString: AuthUrl,
                                    defaultBaseURL: DefaultBaseURL)
       }
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
}
