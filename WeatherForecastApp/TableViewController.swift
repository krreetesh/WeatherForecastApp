//
//  TableViewController.swift
//  WeatherForecastApp
//
//  Created by Reetesh Kumar on 09/05/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import UIKit

class WeatherDataModel : NSObject
{
    var weather_dt: String!
    var weather: String!
    var grnd_level: String!
    var sea_level: String!
    var humidity: String!
    var pressure: String!
    var temp: String!
    var temp_min: String!
    var temp_max: String!
    var wind_speed: String!
    var wind_deg: String!
}

class TableViewController: UITableViewController {

    var cityName: String!
    var dataArray:NSArray!
    var rowArray:NSMutableArray!
    var keyArray:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let city=cityName
        {
            let getURLString:String = "http://samples.openweathermap.org/data/2.5/forecast?q="+"\(city)"+",uk&appid=b6907d289e10d714a6e88b30761fae22"
            
            self.parseTheJSONData(jsonURLStr: getURLString)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //parse the JSON Data
    func parseTheJSONData(jsonURLStr:String) {
        
        //calling display spinner while laoding data
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        //Do your parsing here and fill it into data_array
        let task = URLSession.shared.dataTask(with: NSURL(string: jsonURLStr)! as URL, completionHandler: { (data, response, error) -> Void in
            let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.utf8)
            let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8)
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format!, options: []) as! NSDictionary
                
                self.dataArray = jsonObject.object(forKey: "list") as! NSArray
                
                print(jsonObject)
                
                self.setDataModelToArray(array: self.dataArray)
                
                self.tableView.reloadData()
                
                //calling remove spinner after data loading finished
                UIViewController.removeSpinner(spinner: sv)
                
            } catch {
                print("json error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    // setting data model into array and using protocol delegate method
    func setDataModelToArray(array:NSArray)
    {
        var objModel: WeatherDataModel!
        
        keyArray = ["weather","grnd_level","sea_level","humidity","pressure","temp","temp_min","temp_max","wind_speed","wind_deg"]
        
        rowArray = NSMutableArray()
        
        let rowData: NSMutableArray = NSMutableArray()
        
        for var i in (0..<array.count)
        {
            objModel = WeatherDataModel()
            
            if let ar = dataArray[i] as? [String:AnyObject]{
                
                if let dt = (self.dataArray[i] as AnyObject).value(forKey: "dt_txt") as? String{
                    objModel.weather_dt = dt
                }
                //weather description
                let arr = ar["weather"] as! NSArray
                let descObj = arr[0]
                if let desc = (descObj as AnyObject).value(forKey: "description") {
                    objModel!.weather = "\(desc)"
                }
                //grnd_level
                if let desc = ar["main"]?.value(forKey: "grnd_level") {
                    //rowDict.setValue(desc, forKey: "Grnd_level")
                    objModel?.grnd_level = "\(desc)"
                }
                //sea_level
                if let desc = ar["main"]?.value(forKey: "sea_level") {
                    objModel?.sea_level = "\(desc)"
                }
                //humidity
                if let desc = ar["main"]?.value(forKey: "humidity") {
                    objModel?.humidity = "\(desc)"
                }
                //pressure
                if let desc = ar["main"]?.value(forKey: "pressure") {
                    objModel?.pressure = "\(desc)"
                }
                //temp
                if let desc = ar["main"]?.value(forKey: "temp") {
                    objModel?.temp = "\(desc)"
                }
                //temp_min
                if let desc = ar["main"]?.value(forKey: "temp_min") {
                    objModel?.temp_min = "\(desc)"
                }
                //temp_max
                if let desc = ar["main"]?.value(forKey: "temp_max") {
                    objModel?.temp_max = "\(desc)"
                }
                //wind_speed
                if let desc = ar["wind"]?.value(forKey: "speed") {
                    objModel?.wind_speed = "\(desc)"
                }
                //wind_deg
                if let desc = ar["wind"]?.value(forKey: "deg") {
                    objModel?.wind_deg = "\(desc)"
                }
            }
             rowData.add(objModel)
        }
        rowArray = rowData
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if let array = self.dataArray{
            return array.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.dataArray[section] as AnyObject).value(forKey: "dt_txt") as? String
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let dict = self.keyArray{
            return dict.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let key = keyArray[indexPath.row] as? String
        
        switch key {
        case "weather"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.weather!)"
                cell.textLabel?.text = key
            }
        case "grnd_level"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.grnd_level!)"
                cell.textLabel?.text = key
            }
        case "sea_level"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.sea_level!)"
                cell.textLabel?.text = key
            }
        case "humidity"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.humidity!)"
                cell.textLabel?.text = key
            }
        case "pressure"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.pressure!)"
                cell.textLabel?.text = key
            }
        case "temp"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.temp!)"
                cell.textLabel?.text = key
            }
        case "temp_min"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.temp_min!)"
                cell.textLabel?.text = key
            }
        case "temp_max"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.temp_max!)"
                cell.textLabel?.text = key
            }
        case "wind_speed"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.wind_speed!)"
                cell.textLabel?.text = key
            }
        case "wind_deg"?:
            if let obj = rowArray[indexPath.section] as? WeatherDataModel{
                cell.detailTextLabel!.text = "\(obj.wind_deg!)"
                cell.textLabel?.text = key
            }
        default: break

        }

        return cell
    }
    
}

//display spinner while loading data into table view
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
