/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class AboutAppViewController: UIViewController, UITextViewDelegate {
    
    //create outlet connection for about view
    @IBOutlet weak var aboutView: UITextView!
    
    //create done button functionality
    //returns to main menu
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "About App"
        
        //add description to about app view
        aboutView.text = "Author: Koty Stannard \nApp Version: 1.0.2 \n\nThis app includes several features including: a calorie and macronutrient calculator, a table view of workout routines, and a progress log for the user to store their progress on the scale. \n\nXcode Version: 10.1 \nSwift Version: 4.2 \n\nCocoa Pod: Charts \nCreated By: Daniel Gindi"
        
        //prevent user from editing about page
        aboutView.isEditable = false
    }
}
