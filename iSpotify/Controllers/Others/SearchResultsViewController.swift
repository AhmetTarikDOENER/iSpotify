//
//  SearchResultsViewController.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 12.02.2024.
//

import UIKit

class SearchResultsViewController: UIViewController {

    private var results: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func update(with results: [SearchResult]) {
        self.results = results
    }
}
