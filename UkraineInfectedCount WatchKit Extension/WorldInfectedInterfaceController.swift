//
//  WorldInfectedInterfaceController.swift
//  UkraineInfectedCount WatchKit Extension
//
//  Created by Orest Khomitskyi on 25.08.2020.
//  Copyright © 2020 Orest Khomitskyi. All rights reserved.
//

import WatchKit
import Foundation


class WorldInfectedInterfaceController: WKInterfaceController {
    
    @IBOutlet var updateButton: WKInterfaceButton!
    @IBOutlet var countLabel: WKInterfaceLabel!
    
    @IBAction func buttonClick() {
        self.countLabel.setText("...")
        setCount()
    }
    
    
    private func setCount() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode(ResponseBody.self, from: data)
                     self.countLabel.setText(String(res.Global.TotalConfirmed))
                  } catch let error {
                     print(error)
                    self.countLabel.setText("Error")
                  }
               }
           }.resume()
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        setCount()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
