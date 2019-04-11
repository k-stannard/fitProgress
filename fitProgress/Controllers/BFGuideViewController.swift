/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class BFGuideViewController: UIViewController {

    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womenButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menButton.layer.cornerRadius = 10
        menButton.layer.borderWidth = 0
        womenButton.layer.cornerRadius = 10
        womenButton.layer.borderWidth = 0
    }


}
