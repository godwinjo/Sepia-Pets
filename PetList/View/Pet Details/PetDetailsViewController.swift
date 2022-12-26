//
//  PetDetailsViewController.swift
//  PetList
//
//  Created by Godwin on 26/12/22.
//

import UIKit
import WebKit

class PetDetailsViewController: UIViewController {
    @IBOutlet weak var webViewPetDetails: WKWebView!
    
    var viewModel: PetDetailsViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    func loadWebView() {
        guard let urlRequest = viewModel?.urlRequest else { return }
        webViewPetDetails.load(urlRequest)
    }

}
