//
//  SWHomeViewController.swift
//  SWSearchBar
//
//  Created by Alan on 2019/9/21.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

struct SWCellStruct {
    var id: String = "id"
    var title: String = "title"
    var image: String = "image"
}

enum SWHomeCellIdEnum: String {
    case searchBar = "searchBar"
    case unknown = "unknown"
}


class SWHomeViewController: UIViewController {

    let KUITableViewCell = "UITableViewCell"
    var tableView: UITableView!
    
    var datalist: [SWCellStruct]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.title = "SearchBar"
        
        initData()
        self.setupUI()
        setupSearchBar()
    }
    
    func setupSearchBar() {
        if title == nil {
            title = "SearchBar"
        }
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = UISearchController.init(searchResultsController: nil)
        }
        definesPresentationContext = true
    }
    
    func initData() {
        let data0 = SWCellStruct.init(id: SWHomeCellIdEnum.searchBar.rawValue, title: SWHomeCellIdEnum.searchBar.rawValue, image: "")
        let data1 = SWCellStruct.init(id: SWHomeCellIdEnum.searchBar.rawValue, title: SWHomeCellIdEnum.searchBar.rawValue, image: "")
        let data2 = SWCellStruct.init(id: SWHomeCellIdEnum.searchBar.rawValue, title: SWHomeCellIdEnum.searchBar.rawValue, image: "")
        
        datalist = [data0,
                    data1,
                    data2]
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView = UITableView.init(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .white
        let arrayM = [KUITableViewCell]
        for str in arrayM {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: str) // 纯代码注册
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SWHomeViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count * 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: KUITableViewCell, for: indexPath)
        cell.selectionStyle = .none
        /// 防止数组越界
        var id = ""
        if indexPath.row < datalist.count {
            id = datalist[indexPath.row].id
        }
        else {
            if let identifier = datalist.first?.id {
                id = identifier
            }
        }
        switch id {
        case SWHomeCellIdEnum.searchBar.rawValue:
            cell.textLabel?.text = SWHomeCellIdEnum.searchBar.rawValue
        case SWHomeCellIdEnum.searchBar.rawValue:
            cell.textLabel?.text = SWHomeCellIdEnum.searchBar.rawValue
        default:
            cell.textLabel?.text = SWHomeCellIdEnum.searchBar.rawValue
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        cell.textLabel?.textColor = .darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SWSearchBarViewController.init()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
