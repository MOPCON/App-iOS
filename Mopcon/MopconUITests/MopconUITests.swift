//
//  MopconUITests.swift
//  MopconUITests
//
//  Created by Mikimoto on 2018/9/20.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import XCTest

class MopconUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSnapshots() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let app = XCUIApplication()
      XCUIDevice.shared.orientation = .portrait

      let currentLanguage = Locale.preferredLanguages[0]
      var status = false

      let collectionView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .collectionView).element
      if currentLanguage == "en-US" || currentLanguage == "en" {
        collectionView.swipeUp()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["English"]/*[[".cells.buttons[\"English\"]",".buttons[\"English\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionView.swipeDown()
        status = true
      } else {
        collectionView.swipeUp()
        app.collectionViews.buttons["中文"].tap()
        collectionView.swipeDown()
        status = false
      }

      snapshot("Lanch")

      let cellsQuery = app.collectionViews.cells
      cellsQuery.otherElements.containing(.image, identifier:"Agenda").element.tap()
      snapshot("Agenda")
      if status {
        app.navigationBars["Agenda"].buttons["Item"].tap()
      } else {
        app.navigationBars["議程"].buttons["Item"].tap()
      }

      cellsQuery.otherElements.containing(.image, identifier:"Sponsor").element.tap()
      snapshot("Sponsor")
      if status {
        app.navigationBars["Sponsor"].buttons["Item"].tap()
      } else {
        app.navigationBars["贊助商"].buttons["Item"].tap()
      }

      collectionView.swipeUp()
      cellsQuery.otherElements.containing(.image, identifier:"Speaker").element.tap()
      snapshot("Speaker")
      if status {
        app.navigationBars["Speaker"].buttons["Item"].tap()
      } else {
        app.navigationBars["講者"].buttons["Item"].tap()
      }

      cellsQuery.otherElements.containing(.image, identifier:"Group").element.tap()
      snapshot("Group")
      if status {
        app.navigationBars["Group"].buttons["Item"].tap()
      } else {
        app.navigationBars["社群"].buttons["Item"].tap()
      }
    }

}
