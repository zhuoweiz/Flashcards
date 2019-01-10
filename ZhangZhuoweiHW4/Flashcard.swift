//
//  Flashcard.swift
//  ZhangZhuoweiHW5
//
//  Created by Zhuowei Zhang on 10/19/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import Foundation

struct Flashcard : Equatable {
    private let question:String
    private let answer:String
    
    public var isFavorite:Bool
    
    func getFav() -> String {
        if isFavorite {
            return "true"
        }else {
            return "false"
        }
    }
    
    func getQuestion() -> String {
        return question;
    }
    
    func getAnswer() -> String {
        return answer;
    }
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        isFavorite = false
    }
    
    init(question: String, answer: String, isFavorite: Bool) {
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
    }
}



