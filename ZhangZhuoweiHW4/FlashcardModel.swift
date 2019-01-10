//
//  FlashcardModel.swift
//  ZhangZhuoweiHW5
//
//  Created by Zhuowei Zhang on 10/19/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import Foundation

class FlashcardsModel: FlashcardsDataModel {
    
    private var flashcards: [Flashcard];
    private var currentIndex: Int
    public static let shared = FlashcardsModel()
    
    private var filePath: String
    private let kCardsKey = "flashcards"
    private let kCardQuestionKey = "question"
    private let kCardAnswerKey = "answer"
    private let kCardFavKey = "isFavorite"
    
    func getIndex() -> Int {
        return currentIndex
    }
    
    func isEmpty() -> Bool {
        return flashcards.isEmpty
    }
    
//    private var cardDicComputed: [[String: String]] {
//
//
//        return cardsArray
//    }
//
    init() {
        
        
        currentIndex = 0;
        
        //get a reference to the file path
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let documentDirectory = paths.first!
        
        filePath = "\(documentDirectory)/questions.plist"
        
        //check the file
        if let cardsDictionaries = NSArray(contentsOfFile: filePath) as? [[String: String]] {
            //converting an array of dictionaries to an arry of cards
            flashcards = [Flashcard]()
            
            for cardDictionary in cardsDictionaries {
                var favStatusStr:Bool = false;
                if let favStatus = cardDictionary[kCardFavKey] {
                    if(favStatus=="true") {
                        favStatusStr = true
                    }else {
                        favStatusStr = false
                    }
                }
                
                let card = Flashcard(question: cardDictionary[kCardQuestionKey]!, answer: cardDictionary[kCardAnswerKey]!, isFavorite: favStatusStr)
                flashcards.append(card);
            }
        }else {
            flashcards = [
                Flashcard(question: "When did something start out badly for you but in the end, it was great?", answer: "I don't know"),
                Flashcard(question: "When was Donald Trump born", answer: "I don't want to know the answer."),
                Flashcard(question: "Where is Google's name from", answer: "I guess Larry Page can tell you dat..."),
                Flashcard(question: "Johnny's mother had three children. The first child was named April The second child was named May. What was the third child's name?", answer: "Johnny of course!"),
                Flashcard(question: "What did the pirate say when he turned 80 years old?", answer: "Aye matey.")
            ]
        }
    }
    
    // Swift Singleton pattern
    static let sharedInstance = FlashcardsModel()
    
    // Returns number of flashcards in model
    func numberOfFlashcards() -> Int {
        return self.flashcards.count;
    }
    
    // Returns a flashcard – sets currentIndex appropriately
    func randomFlashcard() -> Flashcard? {
        if(flashcards.count>=1) {
            var randomIndex = Int(arc4random_uniform(UInt32(flashcards.count)))
            while(randomIndex==currentIndex) {
                randomIndex = Int(arc4random_uniform(UInt32(flashcards.count)))
            }
            currentIndex = randomIndex
            return flashcards[randomIndex]
        }else {
            return nil;
        }
    }
    func flashcard(atIndex: Int) -> Flashcard? {
        currentIndex = atIndex
        return self.flashcards[currentIndex];
    }
    func nextFlashcard() -> Flashcard? {
        currentIndex = currentIndex + 1;
        if(currentIndex == flashcards.count) {
            currentIndex = 0;
        }
        return self.flashcards[currentIndex];
    }
    func previousFlashcard() -> Flashcard? {
        currentIndex = currentIndex - 1;
        if(currentIndex == -1) {
            currentIndex = flashcards.count-1;
        }
        return self.flashcards[currentIndex];
    }
    
    // Inserts a flashcard
    func insert(question: String, answer: String,
                favorite: Bool) {
        flashcards.append(Flashcard(question: question, answer: answer, isFavorite: favorite))
        save()
    }
    
    func insert(question: String, answer: String,
                                            favorite: Bool,
                                            atIndex: Int) {
        
        if(atIndex>=0 && atIndex<=flashcards.count) {
            if(atIndex<=currentIndex) {
                currentIndex += 1;
            }
            flashcards.insert(Flashcard(question: question, answer: answer, isFavorite: favorite), at: atIndex)
        }
        save()
    }
    
    // Removes a flashcard
    func removeFlashcard() {
        if(flashcards.count>=1) {
            if((currentIndex != 0) && (currentIndex == flashcards.count-1)) {
                currentIndex -= 1;
            }
            flashcards.removeLast()
        }
        save()
    }
    func removeFlashcard(atIndex: Int) {
        if(atIndex>=0 && atIndex<flashcards.count) {
            if(atIndex<currentIndex) {
                if(currentIndex==0) {
                    currentIndex = 0;
                }else {
                    currentIndex -= 1;
                }
            } else if(currentIndex==flashcards.count-1 && atIndex==currentIndex) {
                currentIndex -= 1;
            }
            flashcards.remove(at: atIndex)
        }
        save()
    }

    // Favorite/unfavorite the current flashcard
    func toggleFavorite() {
        self.flashcards[currentIndex].isFavorite = !self.flashcards[currentIndex].isFavorite;
        save()
    }
    func thisFavStatus() -> Bool{
        return self.flashcards[currentIndex].isFavorite
    }
    
    // Returns the favorite flashcards
    func favoriteFlashcards() -> [Flashcard] {
        var tempArray: [Flashcard] = [];
        for card in flashcards {
            if(card.isFavorite) {
                tempArray.append(card)
            }
        }
        
        return tempArray;
    }
    
    private func save() {
        // array of dictionary objects
        // dictionary has key:value, each is a String
        var cardsArray = [[String:String]]()
        // import object data to an dictionary for data output
        for card in flashcards {
            let cardForFile = [kCardQuestionKey: card.getQuestion(),
                               kCardAnswerKey: card.getAnswer(),
                               kCardFavKey: card.getFav()]
            cardsArray.append(cardForFile)
        }
        
        // convert to NSArray and write to the file
        (cardsArray as NSArray).write(toFile: filePath, atomically: true)
        
        print("saving...")
    }
    
}
