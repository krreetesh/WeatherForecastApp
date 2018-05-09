//
//  MainViewController.swift
//  WeatherForecastApp
//
//  Created by Reetesh Kumar on 09/05/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var txtCityName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueForTableView" {
            if let city=txtCityName.text{
                let vc = segue.destination as! TableViewController
                vc.title = "5 day Weather Forecast in "+"\(city)"
                vc.cityName = city
            }
        }
    }


}

