/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class AboutCalcViewController: UIViewController {

    @IBOutlet weak var aboutCalcView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Calculator Formula"
        
        aboutCalcView.text = "Katch-McArdle Formula \n\nThis formula is determined by calculating the following: \n\nLean Body Mass \n (Weight * (100 - bodyfat)) / 100 \n\nBasic Metabolic Rate \n370 + (21.6 * LBM) \n\nTotal Energy Expenditure \nBMR * Activity Level (1.1 - 1.6) \n\n\nCalories \nTEE +- (TEE * 0.15) (Gain/lose) \n\nProtein \nWeight * 1.0 - 1.3 \n\nFat\nWeight * 0.5 - 0.3 \n\nCarbs \n(Calories - (Protein * 4 + Fat * 9)) / 4"
    }

}
