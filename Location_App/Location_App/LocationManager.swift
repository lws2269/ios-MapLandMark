//
//  LocationManager.swift
//  Location_App
//
//  Created by leewonseok on 2023/03/06.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    var manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        // 권한 받기
        manager.requestWhenInUseAuthorization()

    }
    
    func getMyLocation(completion: @escaping (CLLocation) -> Void) {
        self.completion = completion
//        // 위치 정보 가져오기
//        manager.startUpdatingLocation()
//        // 위치 정보 사용중지
//        manager.stopUpdatingHeading()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            // 위치정보를 가져오기
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.completion?(location)
    }
}
