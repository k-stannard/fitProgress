/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit

class RoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //create table objects
    var strengthObj = [Strength]()
    var hyperObj = [Hypertrophy]()
    
    //create outlets
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var routineTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set title
        navigationItem.title = "Lifting Routines"
        
        //load cell data
        strengthDetails()
        hypertrophyDetails()
    }

    //create seg control functionality
    @IBAction func segControlButtonPressed(_ sender: UISegmentedControl) {
        
        let segIndex = sender.selectedSegmentIndex
        
        switch segIndex {
        case 0:
            self.routineTableView.reloadData()
        case 1:
            self.routineTableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - Table view data source

    //return # of table rows = to object count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRows = 0
        
        switch segControl.selectedSegmentIndex {
            
        case 0:
            numRows = strengthObj.count
        case 1:
            numRows = hyperObj.count
        default:
            break
        }
        
        return numRows
    }

    //setup cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create cell to return
        var cell = UITableViewCell()
        
        //switch control for segmented controlled tables
        switch segControl.selectedSegmentIndex {
        case 0:
            
            //create new object
            let strength:Strength = strengthObj[indexPath.row]
            
            //make reusable cell
            let strengthCell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as! RoutineViewCell
            
            //init cell data
            strengthCell.routineName.text = strength.title
            
            //init cell = object cell
            cell = strengthCell
        case 1:
            //create new object
            let hypertrophy:Hypertrophy = hyperObj[indexPath.row]
            
            //make reusable cell
            let hyperCell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as! RoutineViewCell
            
            //init cell data
            hyperCell.routineName.text = hypertrophy.title
            
            //init cell = object cell
            cell = hyperCell
        default:
            break
        }
        
        return cell
    }
    
    //function to append plist to array for loading data
    func strengthDetails() {
        
        //create path
        let path = Bundle.main.path(forResource: "Strength", ofType: "plist")!
        
        //create array for plist conents
        let strengthArray: NSArray = NSArray(contentsOfFile: path)!
        
        //create array variables
        for item in strengthArray {
            
            let dictionary: [String:String] = (item as? Dictionary)!
            
            let strengthTitle = dictionary["Title"]
            let strengthExercise = dictionary["Exercise List"]
            
            //append object data to array
            strengthObj.append(Strength(title: strengthTitle!, exercise: strengthExercise!))
        }
    }
    
    //function to append pist to array for loading data
    func hypertrophyDetails() {
        
        //create path
        let path = Bundle.main.path(forResource: "Hypertrophy", ofType: "plist")!
        
        //create array for plist conents
        let hypertrophyArray: NSArray = NSArray(contentsOfFile: path)!
        
        //create array variables
        for item in hypertrophyArray {
            
            let dictionary: [String:String] = (item as? Dictionary)!
            
            let hypertrophyTitle = dictionary["Title"]
            let hypertrophyExercise = dictionary["Exercise List"]
            
            //append object data to array
            hyperObj.append(Hypertrophy(title: hypertrophyTitle!, exercise: hypertrophyExercise!))
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailView" {
            let destination = segue.destination as! DetailRoutineViewController
            
            if let indexPath = self.routineTableView.indexPathForSelectedRow {
                
                //switch to control destination data for each table view
                switch segControl.selectedSegmentIndex {
                    
                case 0:
                    let strength:Strength = strengthObj[indexPath.row]
                    
                    destination.detailTitle = strength.title
                    destination.detailExercise = strength.exercise
                case 1:
                    let hypertrophy:Hypertrophy = hyperObj[indexPath.row]
                    
                    destination.detailTitle = hypertrophy.title
                    destination.detailExercise = hypertrophy.exercise
                default:
                    break
                }//end switch
            }//end if
        }//end segue if
    }//end func
}
