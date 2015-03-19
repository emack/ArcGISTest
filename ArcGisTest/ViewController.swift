//
//  ViewController.swift
//  ArcGisTest
//
//  Created by Edmar P. on 3/18/15.
//  Copyright (c) 2015 Edmar P. All rights reserved.
//

import UIKit
import ArcGIS
import WatchKit

class ViewController: UIViewController, AGSMapViewLayerDelegate {

    @IBOutlet weak var mapView: AGSMapView!
    
    let kBasemapLayerName = "Basemap Tiled Layer"
    var typeMap = ["gray","Oceans","NatGeo","Topo","Imagery"]
    
    @IBOutlet weak var uiSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add a basemap tiled layer
        let url = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer")
        let tiledLayer = AGSTiledMapServiceLayer(URL: url)
        self.mapView.addMapLayer(tiledLayer, withName: "Basemap Tiled Layer")
        
        self.mapView.layerDelegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("handleWatchKitNotification:"),
            name: "WatchKitSaysHello",
            object: nil)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        mapView.locationDisplay.startDataSource()
    }
    @IBAction func basemapChanged(sender: UISegmentedControl) {
        
        var basemapURL:NSURL
        switch sender.selectedSegmentIndex {
        case 0: //gray
            basemapURL = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer")!
        case 1: //oceans
            basemapURL = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/Ocean_Basemap/MapServer")!
        case 2: //nat geo
            basemapURL = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer")!
        case 3: //topo
            basemapURL = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer")!
        default: //sat
            basemapURL = NSURL(string: "http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer")!        }
        
        //remove the existing basemap layer
        self.mapView.removeMapLayerWithName(kBasemapLayerName)
        
        //add new Layer
        let newBasemapLayer = AGSTiledMapServiceLayer(URL: basemapURL)
        self.mapView.insertMapLayer(newBasemapLayer, withName: kBasemapLayerName, atIndex: 0);

    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func handleWatchKitNotification(notification: NSNotification) {
        
        //let userInfo:Dictionary<String,Int!> = notification.userInfo as Dictionary<String,Int!>
        //let typeMapIndex = userInfo["typeIndex"]
        let watchIndex = notification.userInfo!
        uiSegment.selectedSegmentIndex = watchIndex["index"] as Int
        basemapChanged(uiSegment)
    }

}

