import XCTest


final class ImageFeedUITests: XCTestCase {
    private let app = XCUIApplication()
        
        override func setUpWithError() throws {
            continueAfterFailure = false
            app.launch()
        }
        
        func testAuth() throws {
            let authButton =  app.buttons["Authenticate"]
            
            XCTAssertTrue(authButton.waitForExistence(timeout: 30))
            authButton.tap()
            
            let webView = app.webViews["UnsplashWebView"]
            
            XCTAssertTrue(webView.waitForExistence(timeout: 10))
            
            
            let loginTextField = webView.descendants(matching: .textField).element
            XCTAssertTrue(loginTextField.waitForExistence(timeout: 10))
            
            loginTextField.tap()
            loginTextField.typeText("")
            app.tap()
            
            
            let passwordTextField = webView.descendants(matching: .secureTextField).element
            XCTAssertTrue(passwordTextField.waitForExistence(timeout: 10))
            
            
            passwordTextField.tap()
            passwordTextField.typeText("")
            app.tap()
            
            
            webView.buttons["Login"].tap()
            
    
            let tablesQuery = app.tables
            let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
            
            XCTAssertTrue(cell.waitForExistence(timeout: 10))
        }
        
        func testFeed() throws {
            let tablesQuery = app.tables

            let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
            cell.swipeUp()

            sleep(2)

            let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)

            cellToLike.buttons["like button off"].tap()
            cellToLike.buttons["like button on"].tap()

            sleep(2)

            cellToLike.tap()

            sleep(2)

            let image = app.scrollViews.images.element(boundBy: 0)
            image.pinch(withScale: 3, velocity: 1)
            image.pinch(withScale: 0.5, velocity: -1)

            let navBackButtonWhiteButton = app.buttons["nav back button white"]
            navBackButtonWhiteButton.tap()
        }
        
        func testProfile() throws {
            sleep(3)
            app.tabBars.buttons.element(boundBy: 1).tap()

            XCTAssertTrue(app.staticTexts["Name Lastname"].exists)
            XCTAssertTrue(app.staticTexts["@username"].exists)

            app.buttons["logout button"].tap()

            app.alerts["Bye bye!"].scrollViews.otherElements.buttons["Yes"].tap()
        }
}
