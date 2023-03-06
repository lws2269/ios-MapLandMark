//
//  MainViewController.swift
//  Location_App
//
//  Created by leewonseok on 2023/02/20.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "LandMark"
//        UISearchController는 코드로만 넣을 수 있음
        mapView.delegate = self
      
        PinLandMark.allCases.forEach {
            let pin = MyPointAnnotation()
            pin.title = $0.title
            pin.coordinate = $0.coordinate
            pin.id = $0.id
            
            self.mapView.addAnnotation(pin)
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let hasView = view.annotation as? MyPointAnnotation else {
             return
        }
        
        let selectedPin = PinLandMark(rawValue: hasView.id)
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.url = selectedPin?.url
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
}

class MyPointAnnotation: MKPointAnnotation {
    var id = 0
}
