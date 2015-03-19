//
//  InterfaceController.swift
//  ArcGisTest WatchKit Extension
//
//  Created by Edmar P. on 3/18/15.
//  Copyright (c) 2015 Edmar P. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    
    
    
    @IBOutlet weak var mapTypeLabel: WKInterfaceLabel!
    //@IBOutlet weak var btnNextMapType: WKInterfaceButton!
    
    var typeMap = ["Gray Map","Oceans Map","NatGeo Map","Topo Map","Imagery Map"]
    var index = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func onButtonClick() {
        if index == 4{
            index = 0
        }else{
            index += 1
        }
        
        WKInterfaceController.openParentApplication(["typeIndex":index], reply: {(response,error) -> Void in println(response)
            var typeIndex = response["typeIndex"] as Int
            var returnedType = self.typeMap[self.index]
        println(returnedType)
            self.mapTypeLabel.setText(returnedType)
        })
        
    }
    

}
