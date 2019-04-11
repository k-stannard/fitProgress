/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class DetailRoutineViewController: UIViewController {


    @IBOutlet weak var detailedTextView: UITextView!
    
    
    
    var detailTitle:String!
    var detailExercise:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = detailTitle
        
        detailedTextView.text = detailExercise
    }


}
