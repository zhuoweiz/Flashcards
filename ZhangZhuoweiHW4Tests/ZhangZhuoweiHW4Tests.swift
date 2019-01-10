//
//  ZhangZhuoweiHW4Tests.swift
//  ZhangZhuoweiHW4Tests
//
//  Created by Zhuowei Zhang on 10/19/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import XCTest
@testable import ZhangZhuoweiHW4

class ZhangZhuoweiHW4Tests: XCTestCase {
    
    private var sharedModel:FlashcardsModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sharedModel = FlashcardsModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSharedModel() {
        let model1 = FlashcardsModel.shared
        let model2 = FlashcardsModel.shared
        // add a flashcard to model1
        model1.insert(question: "testing 1 question", answer: "test 1 answer", favorite: true)
        // check model2 for increase in number of flashcards
        XCTAssertEqual(model1.numberOfFlashcards(), model2.numberOfFlashcards())
    }
    
    func testGetIndex() {
        XCTAssertEqual(0, sharedModel.getIndex())
        let _ = sharedModel.flashcard(atIndex: 4)
        XCTAssertEqual(4, sharedModel.getIndex())
    }
    
    func testRemove() {
        sharedModel.removeFlashcard();
        sharedModel.removeFlashcard();
        XCTAssertEqual(3, sharedModel.numberOfFlashcards())
        sharedModel.removeFlashcard();
        sharedModel.removeFlashcard();
        XCTAssertEqual(0, sharedModel.getIndex())
        sharedModel.removeFlashcard();
        XCTAssertEqual(0, sharedModel.numberOfFlashcards())
        XCTAssertEqual(0, sharedModel.getIndex())
    }
    func testIndexRemove() {
        let testCard = sharedModel.flashcard(atIndex: 3)
        sharedModel.removeFlashcard(atIndex: 2);
        XCTAssertEqual(testCard?.getQuestion(), sharedModel.flashcard(atIndex: 2)?.getQuestion())
        XCTAssertEqual(4, sharedModel.numberOfFlashcards())
        XCTAssertEqual(2, sharedModel.getIndex())
    }
    
    func testInsertion() {
        sharedModel.insert(question: "Test q", answer: "test a", favorite: true)
        XCTAssertEqual(6, sharedModel.numberOfFlashcards())
        XCTAssertEqual(0, sharedModel.getIndex())
        XCTAssertEqual("Test q", sharedModel.flashcard(atIndex: 5)?.getQuestion())
    }
    func testIndexInsersion() {
        sharedModel.insert(question: "Test q", answer: "test a", favorite: true, atIndex: 1)
        XCTAssertEqual("Test q", sharedModel.flashcard(atIndex: 1)?.getQuestion())
        XCTAssertEqual(6, sharedModel.numberOfFlashcards())
    }
    
    func testReturnSize() {
        let originalSize = sharedModel.numberOfFlashcards();
        sharedModel.insert(question: "Test", answer: "test", favorite: true);
        sharedModel.insert(question: "Test", answer: "test", favorite: true);
        sharedModel.insert(question: "Test", answer: "test", favorite: true);
        XCTAssertEqual(originalSize+3, sharedModel.numberOfFlashcards())
    }
    
    func testFlashcard() {
        let tempCard = sharedModel.flashcard(atIndex: 0)
        XCTAssertEqual("When did something start out badly for you but in the end, it was great?", tempCard?.getQuestion())
    }
    
    func testRandomFlashcard() {
        let tempCard1 = sharedModel.randomFlashcard()
        let tempCard2 = sharedModel.randomFlashcard()
        let tempCard3 = sharedModel.randomFlashcard()
        XCTAssertNotEqual(tempCard1, tempCard2)
        XCTAssertNotEqual(tempCard3, tempCard2)
    }
    
    func testNextCard() {
        let _ = sharedModel.flashcard(atIndex: 0)
        let tempCard2 = sharedModel.nextFlashcard()
        XCTAssertEqual(sharedModel.getIndex(), 1)
        XCTAssertEqual(tempCard2?.getQuestion(), "When was Donald Trump born")
    }
    
    func testPrevCard() {
        let _ = sharedModel.flashcard(atIndex: 1)
        let tempCard2 = sharedModel.previousFlashcard()
        XCTAssertEqual(sharedModel.getIndex(), 0)
        XCTAssertEqual(tempCard2?.getQuestion(), "When did something start out badly for you but in the end, it was great?")
    }
    
    func testToggleFav() {
        sharedModel.toggleFavorite()
        XCTAssertEqual(true, sharedModel.flashcard(atIndex: 0)?.isFavorite)
        sharedModel.toggleFavorite()
        XCTAssertEqual(false, sharedModel.flashcard(atIndex: 0)?.isFavorite)
    }
    
    func testFavFlashcards() {
        let tempArr = sharedModel.favoriteFlashcards();
        XCTAssertEqual(0, tempArr.count)
    }

}
