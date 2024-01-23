//
//  TravelTimeSchedulerUITests.swift
//  TravelTimeSchedulerUITests
//
//  Created by t&a on 2023/03/31.
//

import XCTest

final class TravelTimeSchedulerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// サインインテスト
    /// 条件：サインアウト状態であること
    /// 概要：[sample@sample.com/12345678]情報を元にサインインを試みてトップページに画面遷移できたか確認
    func testSignIn() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["gearshape.fill"]/*[[".otherElements[\"gearshape.fill\"].buttons[\"gearshape.fill\"]",".buttons[\"gearshape.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Sign Up"].tap()
        
        app.buttons["登録済みの方はこちら"].tap()

        app.textFields["メールアドレス"].tap()
        app.textFields["メールアドレス"].typeText("sample@sample.com")
        app.secureTextFields["パスワード"].tap()
        app.secureTextFields["パスワード"].typeText("1")  // 「12345678」で入力しようとするとなぜか「2」が抜けるため分割
        app.secureTextFields["パスワード"].typeText("234")
        app.secureTextFields["パスワード"].typeText("5678")
        app.textFields["メールアドレス"].tap()
        
        app.buttons["ログイン"].tap()
        
        let element = app.buttons["旅行登録"]
        XCTAssertTrue(element.waitForExistence(timeout: 5)) // 画面遷移に成功したか
            
    }
    
    /// 新規ユーザー登録テスト
    /// 条件：ユーザー情報が削除されていること
    /// 概要：[User/sample@sample.com/12345678]情報を元に新規登録を試みてトップページに画面遷移できたか確認
    func testNewEntryUser() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*@START_MENU_TOKEN@*/.buttons["gearshape.fill"]/*[[".otherElements[\"gearshape.fill\"].buttons[\"gearshape.fill\"]",".buttons[\"gearshape.fill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Sign Up"].tap()
        
        XCTAssert(app.textFields["ユーザー名"].exists) // 新規登録画面へ遷移

        app.textFields["ユーザー名"].tap()
        app.textFields["ユーザー名"].typeText("User")

        app.textFields["メールアドレス"].tap()
        app.textFields["メールアドレス"].typeText("sample@sample.com")

        app.secureTextFields["パスワード"].tap()
        app.secureTextFields["パスワード"].typeText("12345678")
        
        app.buttons["新規登録"].tap()
        
        let element = app.buttons["旅行登録"]
        XCTAssertTrue(element.waitForExistence(timeout: 5)) // 画面遷移に成功したか
    }
    
    /// Travel記録新規登録テスト
    /// 条件：なし
    /// 概要：旅行情報を新規で登録する
    func testNewEntryTravel() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["旅行登録"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.textFields["旅行名"].tap()
        collectionViewsQuery.textFields["旅行名"].typeText("鹿児島旅行")
        
        let scrollViewsQuery = collectionViewsQuery.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let textField = elementsQuery.textFields["メンバー1"]
        textField.tap()
        textField.typeText("Johnny")
        
        let addBtn = elementsQuery.buttons["追加"]
        addBtn.tap()
        addBtn.tap()

        let textField2 = elementsQuery.textFields["メンバー2"]
        textField2.tap()
        textField2.typeText("Michael")
                
        app.buttons["登録"].tap()
        app.alerts["「鹿児島旅行」を登録しました。"].scrollViews.otherElements.buttons["OK"].tap()
        XCTAssertTrue(app.buttons["旅行登録"].waitForExistence(timeout: 5)) // 画面遷移に成功したか
    }
    
    /// Travel記録新規登録テスト
    /// 条件：なし
    /// 概要：旅行情報を新規で登録する
    func testNewEntrySchedule() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.children(matching: .cell).element(boundBy: 0).buttons["鹿児島旅行"].tap()
        app.buttons["追加"].tap()
        
        app.textFields["内容"].tap()
        app.textFields["内容"].typeText("鹿児島空港")
        
        app.scrollViews.otherElements.buttons["airplane.departure"].tap()


        app.buttons["addScheduleButton"].tap()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.collectionViews.buttons["追加"].tap()
        collectionViewsQuery.collectionViews.scrollViews.otherElements.buttons["機内モード"].tap()
                        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
