//
//  TableViewController.swift
//  WeatherForecastApp
//
//  Created by Reetesh Kumar on 09/05/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var cityName: String!
    var dataArray:NSArray!
    
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
        
        //Do your parsing here and fill it into data_array
        let task = URLSession.shared.dataTask(with: NSURL(string: jsonURLStr)! as URL, completionHandler: { (data, response, error) -> Void in
            let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.utf8)
            let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8)
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format!, options: []) as! NSDictionary
                
                self.dataArray = jsonObject.object(forKey: "list") as! NSArray
                
                print(jsonObject)
                
            } catch {
                print("json error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
