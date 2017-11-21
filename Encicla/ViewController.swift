//
//  ViewController.swift
//  Encicla
//
//  Created by Mateo Echeverri on 11/19/17.
//  Copyright © 2017 Mateo Echeverri. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let margins = mapContainer.layoutMarginsGuide
        image.image = UIImage(named: "enciclaLogo")
        let camera = GMSCameraPosition.camera(withLatitude: 6.207949, longitude: -75.563048, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapContainer.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        let position = CLLocationCoordinate2D(latitude: 6.269267, longitude: -75.5653)
        let london = GMSMarker(position: position)
        london.title = "universidad"
        london.map = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

