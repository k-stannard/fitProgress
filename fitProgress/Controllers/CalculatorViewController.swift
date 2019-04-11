/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class CalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    //outlets for user input text fields
    @IBOutlet weak var userWeight: UITextField!
    @IBOutlet weak var userBodyFat: UITextField!
    @IBOutlet weak var calculateButtonLayout: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var bfButton: UIButton!
    @IBOutlet weak var formulaButton: UIButton!
    
    //calculate button for output
    @IBAction func calculateButton(_ sender: UIButton) {
        
        //capture user inputs and store values
        let weightInput = Int(userWeight.text!)
        let bodyfatInput = Int(userBodyFat.text!)
        var activityInput = 0.0
        
        var calorieOutput:Double
        var proteinOutput:Double
        var fatOutput:Double
        var carbOutput:Double
        
        //add value to activity level depending on selected value in picker view
        if activityLevelTextField.text == "Sedentary" {
            
            activityInput = 1.1
        }
        else if activityLevelTextField.text == "Lightly Active" {
            
            activityInput = 1.2
        }
        else if activityLevelTextField.text == "Moderately Active" {
            
            activityInput = 1.4
        }
        else if activityLevelTextField.text == "Heavily Active" {
            
            activityInput = 1.6
        }
        
        //call alert if text field is empty when button is pressed
        guard let _ = userWeight.text, userWeight.text?.count != 0 else {
            alert()
            return
        }
        
        //same as above
        guard let _ = userBodyFat.text, userBodyFat.text?.count != 0 else {
            alert()
            return
        }
        
        //store TEE value for later
        let tee = teeCalculator(weight: weightInput!, bodyfat: bodyfatInput!, activity: activityInput)
        
        //if user selects gain weight in picker view
        if goalTextField.text == "Gain Weight" {
            
            //calculate calories and macros with specified values
            calorieOutput = (tee + (tee * 0.15))
            proteinOutput = Double(weightInput!) * 1.0
            fatOutput = Double(weightInput!) * 0.5
            carbOutput = (calorieOutput - (proteinOutput * 4 + fatOutput * 9)) / 4
            
            //round numbers for nice output
            calorieOutput.round()
            proteinOutput.round()
            fatOutput.round()
            carbOutput.round()
            
            //display values on view controller
            calories.text = "\(Int(calorieOutput))"
            proteins.text = "\(Int(proteinOutput))g"
            fats.text = "\(Int(fatOutput))g"
            carbs.text = "\(Int(carbOutput))g"
        }
        else if goalTextField.text == "Lose Weight" { //same process for 2nd goal option as above
            
            calorieOutput = (tee - (tee * 0.15))
            proteinOutput = Double(weightInput!) * 1.3
            fatOutput = Double(weightInput!) * 0.30
            carbOutput = (calorieOutput - (proteinOutput * 4 + fatOutput * 9)) / 4
            
            calorieOutput.round()
            proteinOutput.round()
            fatOutput.round()
            carbOutput.round()
            
            calories.text = "\(Int(calorieOutput))"
            proteins.text = "\(Int(proteinOutput))g"
            fats.text = "\(Int(fatOutput))g"
            carbs.text = "\(Int(carbOutput))g"
        }
    }
    
    //create outlets for labels and text fields
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var proteins: UILabel!
    @IBOutlet weak var activityLevelTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add delegates to user text fields
        userWeight.delegate = self
        userBodyFat.delegate = self
        
        //round button
        calculateButtonLayout.layer.cornerRadius = 10
        calculateButtonLayout.layer.borderWidth = 0
        activityButton.layer.cornerRadius = 10
        bfButton.layer.cornerRadius = 10
        formulaButton.layer.cornerRadius = 10

        //call function to hide keypad
        hideKeypad()
     
        navigationItem.title = "Calorie Calculator"
        
        //initialize the 2 picker views and add delegate/datasource
        activityLevelTextField.inputView = pickerView
        goalTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self

        //placeholder text for picker views
        activityLevelTextField.placeholder = "Select Activity Level"
        goalTextField.placeholder = "Select Goal"
    }
    
    @IBAction func activityGuideButton(_ sender: UIButton) {
        activityAlertGuide()
    }
    
    //Function to calculate user's Total Energy Expenditure
    func teeCalculator(weight:Int, bodyfat:Int, activity:Double) -> Double {
        
        //convert to kilos for Katch-McArdle formula
        let kilos = Double(weight) / 2.2
        
        //calculate lean body mass and basic metabolic rate
        let lbm = (kilos * (100 - Double(bodyfat))) / 100
        let bmr = 370 + (21.6 * lbm)
        
        //calculate total energy expenditure
        let tee = bmr * activity
        
        return tee
    }
    
    //arrays of options for picker views
    let activityLevelOptions = ["Sedentary", "Lightly Active", "Moderately Active", "Heavily Active"]
    let goalOptions = ["Gain Weight", "Lose Weight"]
    
    //create picker view variable
    var pickerView = UIPickerView()
    
    //return 1 component of picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    //return # of items in picker view arrays
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if activityLevelTextField.isEditing {
            return activityLevelOptions.count
        }
        else {
            return goalOptions.count
        }
    }

    //show selected row in picker views depending on active text field
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if activityLevelTextField.isEditing{
            return activityLevelOptions[row]
        }
        else {
            return goalOptions[row]
        }
    }
    
    //allow user to select an option and dismiss picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activityLevelTextField.isEditing {
            
            activityLevelTextField.text = activityLevelOptions[row]
            activityLevelTextField.resignFirstResponder()
        }
        else {
         
            goalTextField.text = goalOptions[row]
            goalTextField.resignFirstResponder()
        }
    }
}

//extension of UIViewController to add hide keypad functionality and alert function
extension UIViewController {

    func hideKeypad() {

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    
    func alert() {
        
        //alert title
        let title = NSLocalizedString("Empty Field", comment: "")
        
        //alert message
        let message = NSLocalizedString("Please enter a value in the empty field(s)", comment: "")
        
        //set okay button
        let cancelButtonTitle = NSLocalizedString("Okay", comment: "")
        
        //init alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //init cancel action
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            print("Alert cancel occurred.")
        }
        
        //add cancel action to alert
        alertController.addAction(cancelAction)
        
        //present the alert controller.
        present(alertController, animated: true, completion: nil)
    }
    
    //alert for activity level guide
    func activityAlertGuide() {
        
        //alert title
        let title = NSLocalizedString("Activity Levels", comment: "")
        
        //alert message
        let message = NSLocalizedString("Sedentary: Little to no exercise. \nLight: 1-3 hours/week of exercise \nModerate: 3-5 hours/week of exercise \nHeavy: 6+ hours/week of exercise", comment: "")
        
        //set okay button
        let cancelButtonTitle = NSLocalizedString("Okay", comment: "")
        
        //init alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //init cancel action
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            print("Alert cancel occurred.")
        }
        
        //add cancel action to alert
        alertController.addAction(cancelAction)
        
        //present the alert controller.
        present(alertController, animated: true, completion: nil)
    }
}
