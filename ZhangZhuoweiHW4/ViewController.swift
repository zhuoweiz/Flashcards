//
//  ViewController.swift
//  ZhangZhuoweiHW5
//
//  Created by Zhuowei Zhang on 10/19/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Singliton
    var sharedModel = FlashcardsModel.shared
    
    // IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var singleTap: UITapGestureRecognizer!
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    // Instance variables
    var fadeOutAnimator: UIViewPropertyAnimator?
    var fadeInAnimator: UIViewPropertyAnimator!
    var doubleAnimator: UIViewPropertyAnimator!
    
    var favAnimator: UIViewPropertyAnimator!
    var favFadeInAnimator: UIViewPropertyAnimator!
    var favFadeOutAnimator: UIViewPropertyAnimator!
    
    // other variables
    var onAnswer : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let randomeQuest = sharedModel.randomFlashcard();
        questionLabel.text = randomeQuest?.getQuestion();
        
        singleTap.require(toFail: doubleTap)
    }
    
    
    func reload() {
        if(!sharedModel.isEmpty()) {
            let randomeQuest = sharedModel.randomFlashcard();
            questionLabel.text = randomeQuest?.getQuestion();
            questionLabel.textColor = UIColor.black;
            print("reloading")
        }else {
            questionLabel.text = "There are no more flashcards."
        }
    }
    
    //IBActions
    @IBAction func singleTapped(_ sender: UITapGestureRecognizer) {
        onAnswer = false;
        if(!sharedModel.isEmpty()) {
            let randomeQuest = sharedModel.randomFlashcard();
            questionLabel.text = randomeQuest?.getQuestion();
            questionLabel.textColor = UIColor.black;
            print("single tapped")
        }else {
            questionLabel.text = "There are no more flashcards."
        }
    }
    
    @IBAction func doubleTapped(_ sender: UITapGestureRecognizer) {
        if(!onAnswer) {
            onAnswer = true;
            if(!sharedModel.isEmpty()) {
                //fade out
                doubleAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: {
                    self.fadeOutLabel()
                })
                doubleAnimator.addCompletion { (position) in
                    let questionAnswer = self.sharedModel.flashcard(atIndex: self.sharedModel.getIndex())?.getAnswer();
                    self.questionLabel.text = questionAnswer;
                    print("double tapped");
                    self.questionLabel.textColor = UIColor.orange;
                    
                    //fade in
                    let animator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: self.fadeInLabel)
                    animator.startAnimation()
                }
                doubleAnimator.startAnimation();
            } else {
                questionLabel.text = "Please add more flashcards."
            }
        } else {
            onAnswer = false;
            if(!sharedModel.isEmpty()) {
                //fade out
                doubleAnimator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: {
                    self.fadeOutLabel()
                })
                doubleAnimator.addCompletion { (position) in
                    let question = self.sharedModel.flashcard(atIndex: self.sharedModel.getIndex())?.getQuestion();
                    self.questionLabel.text = question;
                    print("double tapped");
                    self.questionLabel.textColor = UIColor.black;
                    
                    //fade in
                    let animator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: self.fadeInLabel)
                    animator.startAnimation()
                }
                doubleAnimator.startAnimation();
            } else {
                questionLabel.text = "There are no more flashcards."
            }
        }
        
    }
    
    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
        let nextQuest = sharedModel.nextFlashcard();
        questionLabel.text = nextQuest?.getQuestion();
        questionLabel.textColor = UIColor.black;
        print("swiped next: ")
    }
    
    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        let nextQuest = sharedModel.previousFlashcard();
        questionLabel.text = nextQuest?.getQuestion();
        questionLabel.textColor = UIColor.black;
        print("swipe prev: ")
    }
    
    @IBOutlet weak var favPop: UILabel!
    @IBAction func swipedUp(_ sender: UISwipeGestureRecognizer) {
        //change from unfav to fav
        //fade in
        favAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
            if(self.sharedModel.thisFavStatus()) {
                self.favPop.text = "UNfavorited";
            } else {
                self.favPop.text = "Favorited";
            }
            self.fadeInFavLabel()
        })
        favAnimator.addCompletion { (position) in

            print("up swiped");
            
            //fade out
            let animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: self.fadeOutFavLabel)
            animator.startAnimation()
        }
        favAnimator.startAnimation();
        
        sharedModel.toggleFavorite();
    }
    
    
    
//    @IBAction func swipedLeft(_ sender: UISwipeGestureRecognizer) {
//        let nextQuest = sharedModel.previousFlashcard();
//        questionLabel.text = nextQuest?.getQuestion();
//        print("swipe left: ")
//    }
//
//    @IBAction func swipedRight(_ sender: UISwipeGestureRecognizer) {
//        let nextQuest = sharedModel.nextFlashcard();
//        print("swipe left")
//        questionLabel.text = nextQuest?.getQuestion();
//    }
//    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
//        let nextQuest = sharedModel.previousFlashcard();
//        questionLabel.text = nextQuest?.getQuestion();
//        print("swiped right: ")
//    }
    
    
    
    //helper functions
    func fadeOutLabel() {
        questionLabel.alpha = 0
    }
    
    func fadeInLabel() {
        questionLabel.alpha = 1
    }
    
    func fadeOutFavLabel() {
        favPop.alpha = 0
    }
    
    func fadeInFavLabel() {
        favPop.alpha = 1
    }
}

