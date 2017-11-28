//
//  ViewController.swift
//  Encicla
//
//  Created by Mateo Echeverri on 11/19/17.
//  Copyright © 2017 Mateo Echeverri. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,  GMSMapViewDelegate {

    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var logo: UIImageView!
    
    var stations: [Station] = []
    var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Facade.downloadJson{ result in
            
            self.stations = result
            
            for (index, station) in self.stations.enumerated() {
 
                    self.markers.append(self.createmarker(station: station, index: index))

            }
            self.createMap(markers: self.markers)
        }
    }
    
    func createMap(markers: [GMSMarker]){
        UIApplication.shared.windows.last?.backgroundColor = .white
        view.backgroundColor = UIColor(red: 0.0745098039, green: 0.48627451, blue:0.811764706 , alpha: 0.5)
        logo.image = UIImage(named: "enciclaLogo")
        logo.backgroundColor = UIColor(red: 0.0745098039, green: 0.48627451, blue:0.811764706 , alpha: 0.1)
        self.logo.layer.cornerRadius = 25
        self.logo.layer.masksToBounds = true
        
        let camera = GMSCameraPosition.camera(withLatitude: 6.245322, longitude:-75.576857, zoom: 15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        do {
            // Set the map style by passing a valid JSON string.
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: URL(fileReferenceLiteralResourceName: "mapConf.json"))
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        mapContainer.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: mapView, attribute: .leading, relatedBy: .equal, toItem: mapContainer, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .top, relatedBy: .equal, toItem: mapContainer, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .trailing, relatedBy: .equal, toItem: mapContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mapView, attribute: .bottom, relatedBy: .equal, toItem: mapContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
        for marker in markers {
            marker.map = mapView
        }
    }
    
    public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let nib = UINib(nibName: "WindowView", bundle: Bundle.main)
        print("*******************************************************")
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? WindowView else {print("fuck"); return nil}
        

        view.name.text = stations[Int(marker.accessibilityLabel!)!].name
        view.direction.text = stations[Int(marker.accessibilityLabel!)!].address.lowercased().capitalized.replacingOccurrences(of: "Con Carrera", with: "#").replacingOccurrences(of: " - Carrera ", with: " # ").replacingOccurrences(of: " Con Calle ", with: " # ").replacingOccurrences(of: " Con ", with: " # ")
        print(stations[Int(marker.accessibilityLabel!)!].address.lowercased().capitalized)
        view.instructions.text = stations[Int(marker.accessibilityLabel!)!].description
        
        view.availability.text = String(stations[Int(marker.accessibilityLabel!)!].bikes) + " ciclas de " + String(stations[Int(marker.accessibilityLabel!)!].capacity)


        
        

        return view
    }
    
    func createmarker (station: Station, index: Int)->GMSMarker {
        let position = CLLocationCoordinate2D(latitude: Double(station.lat)!, longitude: Double(station.lon)!)
        let marker = GMSMarker(position: position)
        let a = UIImageView(image: #imageLiteral(resourceName: "available"))
        let u = UIImageView(image: #imageLiteral(resourceName: "unavailable"))
        a.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        u.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        marker.iconView = station.bikes>0 ? a : u
        marker.accessibilityLabel = String(index)
        return marker
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

