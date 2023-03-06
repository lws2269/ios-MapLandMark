//
//  PinLandMark.swift
//  Location_App
//
//  Created by leewonseok on 2023/03/06.
//

import Foundation
import MapKit

enum PinLandMark: Int, CaseIterable {
    case Deoksugung = 100
    case GyeongbokGung = 200
    case SeoulCityHall = 300
}


extension PinLandMark {
    
    var title: String {
        return "\(self)"
    }
    
    var id: Int {
        return self.rawValue
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .Deoksugung:
            return .init(latitude: 37.5658049, longitude: 126.9751461)
        case .GyeongbokGung:
            return .init(latitude: 37.5662952, longitude: 126.9779451)
        case .SeoulCityHall:
            return .init(latitude: 37.5785635, longitude: 126.9769535)
        }
    }
    
    var url: URL? {
        switch self {
        case .Deoksugung:
            return .init(string: "https://www.deoksugung.go.kr/")
        case .GyeongbokGung:
            return .init(string: "https://www.royalpalace.go.kr/")
        case .SeoulCityHall:
            return .init(string: "https://www.seoul.go.kr/main/index.jsp")
        }
    }
}
