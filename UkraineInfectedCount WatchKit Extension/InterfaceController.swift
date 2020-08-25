//
//  InterfaceController.swift
//  UkraineInfectedCount WatchKit Extension
//
//  Created by Orest Khomitskyi on 25.08.2020.
//  Copyright © 2020 Orest Khomitskyi. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var updateButton: WKInterfaceButton!
    @IBOutlet var countLabel: WKInterfaceLabel!
    
    @IBAction func buttonClick() {
        print("Click")
        self.countLabel.setText("...")
        setCount()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        print("Application Started");
    }
    
    private func setCount() {
        if let url = URL(string: "https://api.covid19api.com/summary") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode(ResponseBody.self, from: data)
                     let UkraineInfo = res.Countries.first(where: { $0.Country == "Ukraine" })!
                    if UkraineInfo != nil {
                        self.countLabel.setText(String(UkraineInfo.TotalConfirmed))
                    }
                    else {
                        self.countLabel.setText("Error")
                    }
                  } catch let error {
                     print(error)
                    self.countLabel.setText("Error")
                  }
               }
           }.resume()
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        setCount()

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
