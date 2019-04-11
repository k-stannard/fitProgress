/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class AddProgressViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    let datePicker = UIDatePicker()
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Add Weight"
        hideKeypad()
        textFieldDidBeginEditing(dateText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displayDate(date: date)
    }

    //add save button functionality
    @IBAction func saveButton(_ sender: UIButton) {
        
        //get shared instance to from progress view controller to store userWeight from this view controller
        
        guard let input = inputTextField.text else { return }
        
        if let value = Double(input) {
            
            ProgressViewController.sharedInstance.saveWeight(userWeight: value, userDate: date)
        }
       
        
        
        //call alert if input field is empty when save is pressed
        guard let _ = inputTextField.text, inputTextField.text?.count != 0 else {
            
            alert()
            return
        }
        
        //dismiss view
        dismiss(animated: true, completion: nil)
    }
    
    //add cancel button functionality
    @IBAction func cancelButton(_ sender: UIButton) {
        
        //dismiss view
        dismiss(animated: true, completion: nil)
    }
    
    //fill in date when text field is active
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.datePickerMode = .date
        dateText.inputView = datePicker
        datePicker.addTarget(self, action: #selector(addDateToField), for: .valueChanged)
    }
    
    //add date to field
    @objc func addDateToField(sender: UIDatePicker) {
        
        displayDate(date: sender.date)
    }
    
    //display and format date function for text field
    func displayDate(date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        dateText.text = formatter.string(from: date)
        self.date = date
    }
}
