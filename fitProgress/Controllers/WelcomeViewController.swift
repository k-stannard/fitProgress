/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var calculatorButton: UIButton!
    @IBOutlet weak var routineButton: UIButton!
    @IBOutlet weak var trackerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavInfoButton()
        
        customButton()
        menuLogoDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isToolbarHidden = true
    }

    func menuLogoDesign() {
        
        //create menu logo
        //and set the frame
        let menuLogo = UIImage(named: "Logo1.png")
        let imageView = UIImageView(image: menuLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 84, y: 122, width: 213, height: 180)
        
        //add image to view
        view.addSubview(imageView)
    }
    
    func customButton() {
        
        //round buttons
        calculatorButton.layer.cornerRadius = 10
        calculatorButton.layer.borderWidth = 0
        view.bringSubviewToFront(calculatorButton)
        
        routineButton.layer.cornerRadius = 10
        routineButton.layer.borderWidth = 0
        view.bringSubviewToFront(routineButton)
        
        trackerButton.layer.cornerRadius = 10
        trackerButton.layer.borderWidth = 0
        view.bringSubviewToFront(trackerButton)
    }
    
    //function to add info light button to nav bar
    //redirects to about app view
    func addNavInfoButton() {
        
        let button = UIButton(type: .infoLight)
        button.addTarget(self, action: #selector(self.showAboutAppView), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    //function to create about app view
    @objc func showAboutAppView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutAppNavigationController") as! UINavigationController
        
        self.present(controller, animated: true, completion: nil)
    }

}

