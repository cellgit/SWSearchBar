//
//  SWCustomSearchBar.swift
//  SWSearchBar
//
//  Created by Alan on 2019/9/29.
//  Copyright © 2019 liuhongli. All rights reserved.
//

/*
ios13之后不润徐使用私有属性,这个类是为了在全面适配ios13之前的一个替代性方法
*/

import UIKit

class SWCustomSearchBar: UISearchBar {

    var searchFiel : UITextField! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        //searchBar.delegate = self
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        //searchBar.showsCancelButton = true
        self.setImage(UIImage.init(named: ""), for: .clear, state: .normal)
        self.setImage(UIImage.init(named: "sousuo_fangdajing_icon"), for: .search, state: .normal)
        self.contentMode = .left
        self.backgroundImage = UIImage()
        // 设置SearchBar的颜色主题为白色
        self.barTintColor = .white
        self.setTextFieldDefaultColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setIconForSearch(img:UIImage){
        self.setImage(img, for: .search, state: .normal)
    }
    //clearSearch

    func setIconForClear(img:UIImage){
        self.setImage(img, for: .clear, state: .normal)
    }

    func setPlaceHolderColor(color:UIColor){
        if #available(iOS 13.0, *) {
            #warning("ios13")
            self.searchFiel.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : color])
        }
        else {
            self.searchFiel.setValue(color, forKey: "_placeholderLabel.textColor")
        }
    }

    func setTextFieldColor(color:UIColor){
        if #available(iOS 13.0, *) {
            self.searchTextField.backgroundColor = color
        }
        else {
            let searchField: UITextField = self.value(forKey: "_searchField") as! UITextField
            searchField.backgroundColor = color
        }
    }
    
    func setTextFieldDefaultColor(){
        if #available(iOS 13.0, *) {
            self.searchTextField.layer.cornerRadius = 14.0
            self.searchTextField.layer.borderColor = UIColor.clear.cgColor
            self.searchTextField.layer.borderWidth = 1.0
            self.searchTextField.backgroundColor = UIColor.init(red: 242, green: 242, blue: 242, alpha: 1.0)
            self.searchTextField.layer.masksToBounds = true
            self.searchTextField.font = UIFont.systemFont(ofSize: 14)
            self.searchFiel = self.searchTextField
        }
        else {
            let searchField: UITextField = self.value(forKey: "_searchField") as! UITextField
            self.searchFiel = searchField
            searchField.layer.cornerRadius = 14.0
            searchField.layer.borderColor = UIColor.clear.cgColor
            searchField.layer.borderWidth = 1;
            searchField.layer.masksToBounds = true;
            searchField.backgroundColor = UIColor.init(red: 242, green: 242, blue: 242, alpha: 1.0)
            searchField.backgroundColor = UIColor.init(white: 0.6, alpha: 0.5)
        }
    }
}
