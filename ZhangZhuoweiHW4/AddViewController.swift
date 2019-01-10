//
//  AddViewController.swift
//  ZhangZhuoweiHW5
//
//  Created by Joey on 11/5/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import UIKit

typealias AddCompletionHandler = ((_ question: String?, _ answer: String?) -> Void)

class AddViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //cancel keyboard when enter

    @IBOutlet weak var questionAddField: UITextView!
    @IBOutlet weak var answerAddField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    var completionHandler: AddCompletionHandler?
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        if let question = questionAddField.text, let answer = answerAddField.text, let completionHandler = self.completionHandler {
            completionHandler(question, answer)
            
            questionAddField.text = nil
            answerAddField.text = nil
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        //hide keyboard
        self.view.endEditing(true)
        
        //reset textfield and textview
        questionAddField.text = nil
        answerAddField.text = nil
        
        if let completionHandler = self.completionHandler {
            
            completionHandler(nil, nil)
            
            //go back to the table
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //tap gesture keybaord hide
    @IBAction func singleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if let text1 = answerAddField.text?.isEmpty {
            if(questionAddField.text.isEmpty || text1) {
                saveButtonOutlet.isEnabled = false
            }else {
                saveButtonOutlet.isEnabled = true
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("new joke...")
        
        if let text1 = answerAddField.text?.isEmpty {
            if(questionAddField.text.isEmpty || text1) {
                saveButtonOutlet.isEnabled = false
            }else {
                saveButtonOutlet.isEnabled = true
            }
        }
        
        return true;
    }
    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let changedString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        
        // String -> Native Swift Data type
        // NSString -> Objective-C Bridge Data Type
        
        enableSubmitButton(answer: answerAddField.text!, question: changedString)
        
        return true
    }
    
    // MARK: - Private Functions
    
    private func enableSubmitButton(answer: String, question: String){
        
        // If either textview or textfield is empty, thne disable button
        if answer.isEmpty || question.isEmpty{
            saveButtonOutlet.isEnabled = false
        } else{
            saveButtonOutlet.isEnabled = true
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
