//
//  SWSearchBarViewController.swift
//  SWSearchBar
//
//  Created by Alan on 2019/9/21.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

class SWSearchBarViewController: UIViewController {
    let kPadding: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom SearchBar"

        self.view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        let searchBarView = SWSearchBarView.init(frame: CGRect(x: kPadding, y: 200, width: self.view.bounds.width - kPadding*2*2, height: 38))
        self.navigationItem.titleView = searchBarView   // 添加到navigation
        self.view.addSubview(searchBarView) //添加到普通view
        searchBarView.delegate = self
    }
}

extension SWSearchBarViewController: SWSearchBarDelegate {
    func sw_searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText ===== \(searchText)")
    }
}
