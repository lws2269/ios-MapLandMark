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
    
    var searchController: UISearchController!
    var resultsController: SearchResultsTableViewController!
    var filteredLandMarks = [PinLandMark]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "LandMark"
        //        UISearchController는 코드로만 넣을 수 있음
        mapView.delegate = self
        
        addPin()
        makeResultsController()
        makeSearchController()
    }
    
    private func makeSearchController() {
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
    }
    
    private func makeResultsController() {
        resultsController = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultsTableViewController") as? SearchResultsTableViewController
        
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
    }
    
    func addPin() {
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
        self.navigationItem.title = selectedPin?.title
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
        // 선택한 핀 선택해제
        self.mapView.deselectAnnotation(view.annotation, animated: true)
        
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLandMarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        cell.title.text = filteredLandMarks[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedPin = PinLandMark(rawValue: filteredLandMarks[indexPath.row].id) else {
            return
        }

        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let regian = MKCoordinateRegion(center: selectedPin.coordinate, span: span)
        
        self.mapView.setRegion(regian, animated: true)
        
        // searchController를 비활성화 시키는 여러가지 방법
//        searchController.searchBar.text = ""
      searchController.isActive = false
        self.navigationItem.title = selectedPin.title
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        let pinAllList = PinLandMark.allCases
        
        filteredLandMarks = pinAllList.filter{
            return $0.title.lowercased().contains(searchText.lowercased())
        }
        resultsController.tableView.reloadData()
    }
    
}

class MyPointAnnotation: MKPointAnnotation {
    var id = 0
}
