/****************************************
 Koty Stannard
 z1811773
 CSCI 427 Fall 2018
 iOS App Project: fitProgress
 
 Optimized for iPhone Xs
 
 Due: December 13, 2018
 ****************************************/

import UIKit
import CoreData
import Charts

class ProgressViewController: UIViewController, ChartViewDelegate, UITableViewDelegate {
    
    //result outlets
    @IBOutlet weak var progressTableView: UITableView!
    @IBOutlet weak var lineChartView: LineChartView!

    @IBOutlet weak var refreshButton: UIButton!
    
    
    //create shared instance to share function between add view controller
    static let sharedInstance = ProgressViewController()
    var context: NSManagedObjectContext!

    var weight : [NSManagedObject] = []
    var lineChartEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Progress Log"
        
        //set table delegate
        //register
        //and remove empty cells
        //NEED TO USE "cell" IN REGISTER EVERY TIME
        //NO MATTER WHAT YOU USE AS CELL IDENTIFIER IN STORYBOARD!!!!
        progressTableView.delegate = self
        //lineChartView.delegate = self
        progressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        progressTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDel()
        
        fetchData()
        
        setChartData()
        
        self.progressTableView.reloadData()
    }
    
    
    /////////////////////////////
    //MARK - CoreData Functions//
    /////////////////////////////
    
    //function to store core data
    func saveWeight(userWeight: Double, userDate: Date) {
        
        //call the app delegate and context
        appDel()
        
        //create entity container
        let weightEnt = NSEntityDescription.insertNewObject(forEntityName: "Weight", into: context) as! Weight
        
        //init values to entity container
        weightEnt.weights = userWeight
        weightEnt.date = userDate
        
        //append values to array
        weight.append(weightEnt)
        
        //save data
        saveContext()
    }
    
    //separate function to save context
    func saveContext() {
        
        do {
            try context.save()
        }
        catch let error as NSError {
        print("Could not save. \(error), \(error.description)")
        }
    }
    
    //separate function for app delegate and context calls
    func appDel() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        context = appDelegate.persistentContainer.viewContext
    }
    
    //separate func for fetch request
    func fetchData() {
        
        //create fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weight")
        
        //create sort descriptor by date
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        
        //call sort
        fetchRequest.sortDescriptors = [dateSort]

        //fetch results
        do {
            weight = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.description)")
        }
    }
    
    
    
    //////////////////////////
    //MARK - Chart Functions//
    //////////////////////////

    //function to create chart data
    //currently not fully functioning
    //date format reference from: https://github.com/danielgindi/Charts/issues/2094
    func setChartData() {
        
        let xAxis1 = lineChartView.xAxis
        
        appDel()
        
        //create fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weight")
        
        //fetch results
        do {
            let result = try context.fetch(fetchRequest)
            
            for data in result as! [Weight] {
                
//                let timeInterval = data.date?.timeIntervalSince1970
//                let xDate = Double(timeInterval!) / (360000 * 24)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone?
                
                var miniDate : Double = 0.0
                
                let dateString = dateFormatter.string(from: data.date!)
                
                xAxis1.granularityEnabled = true
                xAxis1.granularity = 1.0
                
                //get values of data and append
                for i in 0..<weight.count {
                    
                    let myDateMidnightLocalTime = dateFormatter.date(from: dateString)
                    let timeInSeconds = myDateMidnightLocalTime?.timeIntervalSince1970
                    if i == 0
                    {
                        miniDate = timeInSeconds!
                    }
                    
                    let val = ChartDataEntry(x: (timeInSeconds! - miniDate) / (3600.0 * 24.0), y: data.weights)
                    lineChartEntry.append(val)
                }
                
                xAxis1.valueFormatter = DateValueFormatter(miniTime : miniDate)
                
            }
            
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.description)")
        }
        
        //create the line
        let line = LineChartDataSet(values: lineChartEntry, label: "Weight")
        
        //customize chart layout view
        line.colors = [NSUIColor.white]

        xAxis1.labelTextColor = UIColor.white
        self.lineChartView.leftAxis.labelTextColor = UIColor.white
        lineChartView.rightAxis.enabled = false
        xAxis1.labelPosition = XAxis.LabelPosition.bottom
        self.lineChartView.leftAxis.axisMinimum = 0.0

        
        let xAxis : XAxis = self.lineChartView.xAxis
        xAxis.labelFont = UIFont(name: "Avenir", size: 14.0)!
        lineChartView.leftAxis.labelFont = UIFont(name: "Avenir", size: 14.0)!
        lineChartView.chartDescription?.text = ""
        line.drawValuesEnabled = false
        
        //initialize chart data
        let data = LineChartData()
        

        //add data to set
        data.addDataSet(line)
        
        //graph data
        self.lineChartView.data = data
    }

}

// MARK: - UITableViewDataSource
extension ProgressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weight.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //setup var to get data
        let userWeight = weight[indexPath.row] as! Weight
        
        //setup reuseable cell
        let weightCell = progressTableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressViewCell

        //format date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        //store data into cell labels + custom font
        weightCell.wtlabel.text = String(userWeight.weights) + " lbs"
        weightCell.wtlabel.font = UIFont(name: "Avenir", size: 20)
        weightCell.dtlabel.text = formatter.string(from: userWeight.date!)
        weightCell.dtlabel.font = UIFont(name: "Avenir", size:20)
        
        return weightCell
    }
    
    //allow user to edit table rows for deletion
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //call app delegate + context
        appDel()
        
        //if editing style is deletion
        if editingStyle == .delete {

            //delete data
            context.delete(weight[indexPath.row])
            
            //update table visually
            tableView.beginUpdates()
            weight.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            //save data
            saveContext()
            
            //reload
            self.progressTableView.reloadData()
        }
    }
}
