//
//  HW4FlashcardModel.swift
//  ITP342HW5
//
//  Created by Harrison Weinerman on 10/5/18.
//  Copyright © 2018 Harrison Weinerman. All rights reserved.
//

import Foundation

protocol FlashcardsDataModel {
    func numberOfFlashcards() -> Int
    func randomFlashcard() -> Flashcard?
    func flashcard(atIndex: Int) -> Flashcard?
    func nextFlashcard() -> Flashcard?
    func previousFlashcard() -> Flashcard?
    func insert(question: String,
                answer: String,
                favorite: Bool)
    func insert(question: String,
                answer: String,
                favorite: Bool,
                atIndex: Int)
    func removeFlashcard()
    func removeFlashcard(atIndex: Int)
    func toggleFavorite()
    func favoriteFlashcards() -> [Flashcard]
}


