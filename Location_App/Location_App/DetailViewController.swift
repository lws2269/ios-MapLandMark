//
//  DetailViewController.swift
//  Location_App
//
//  Created by leewonseok on 2023/03/06.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url {
            webView.load(URLRequest(url: url))
        }
    }
}
