//
//  ViewController.swift
//  API_Demo
//
//  Created by Brian Patterson on 21/10/2016.
//  Copyright © 2016 Brian Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
 
    @IBOutlet weak var cityTextField: UITextField!
    
   
    @IBAction func submit(_ sender: AnyObject) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=8a99df7bf7ef4a4a202732c392b2d240&units=metric") {
        
        let task = URLSession.shared.dataTask(with: url) { (data,response, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        
                        print(jsonResult["name"]!!)
                        
                        
                        if let description = ((jsonResult["weather"]as? NSArray)?[0]as? NSDictionary)?["description"]as? String {
                            
                            DispatchQueue.main.sync(execute:) {
                                self.resultLabel.text = description
                            }
                        }
                        if let main = jsonResult["main"] as? NSDictionary {
                            print(main)
                            if let temp = main["temp"] as? Double {
                                DispatchQueue.main.sync(execute:) {
                                self.tempLabel.text = String(format: "%.1fº Centigrade", temp)
                                }
                            }
                        }
                        
                        
                    } catch {
                        print("JSON Processing failed")
                    }
                }
            }
        }
        task.resume()
        
            } else {
            resultLabel.text = "Couldn't find weather for that city"
    }

}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

