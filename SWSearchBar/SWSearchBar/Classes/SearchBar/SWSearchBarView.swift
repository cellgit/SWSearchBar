//
//  SWSearchBarView.swift
//  SWGradient
//
//  Created by Alan on 2019/9/21.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit


protocol SWSearchBarDelegate {
    func sw_searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
}

class SWSearchBarView: UIView {
    
    public var delegate: SWSearchBarDelegate?
    
    open var searchBar: SWSearchBar!
    
    /// 搜索输入框的 UITextField
    var searchField: UITextField!
    
    let tealBlueColor = UIColor.init(red: 0.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    
    /// searchBar占位字符
    open var placeholder: String = "请输入搜索关键字" {
        didSet {
            self.searchBar.placeholder = placeholder
        }
    }
    
    /// searchBar的主题颜色
    open var barTintColor: UIColor = .white {
        didSet {
            self.searchBar.barTintColor = barTintColor
        }
    }
    
    /// 取消按钮的标题
    open var cancelTitle: String = "取消" {
        didSet {
            self.searchBar.sw_cancelButtonTitle(cancelTitle)
        }
    }
    
    /// tintColor
    open var cancelTintColor: UIColor = UIColor.init(red: 0.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0) {
        didSet {
            self.searchBar.tintColor = cancelTintColor
        }
    }
    
    /// 取消按钮的字体字号
    open var cancelFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium) {
        didSet {
            self.searchBar.sw_cancelButtonFont(cancelFont)
        }
    }
    
    /// 搜索图标
    open var searchImage: String = "search" {
        didSet {
            self.searchBar.setImage(UIImage.init(named: searchImage), for: UISearchBar.Icon.search, state: .normal)
        }
    }
    
    /// 光标颜色
    open var cursorTintColor: UIColor = UIColor.init(red: 0.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0) {
        didSet {
            searchField.tintColor = cursorTintColor
        }
    }
    
    /// 搜索框(textField)背景色
    var searchFieldBgColor: UIColor = UIColor.init(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0) {
        didSet {
            searchField.backgroundColor = searchFieldBgColor
        }
    }
    
    /// 搜索圆角半径:
    open var cornerRadius: CGFloat = 15 {
        didSet {
            searchField.layer.cornerRadius = cornerRadius
        }
    }
    
    /// 搜索关键字的颜色
    open var searchFieldColor: UIColor = .darkGray {
        didSet {
            self.searchBar.sw_textColor(searchFieldColor)
        }
    }
    
    /// 搜索关键字的字体字号
    open var searchFieldFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.searchBar.sw_textFont(searchFieldFont)
        }
    }
    
    /// textField的边线宽度
    open var borderColor: CGColor = UIColor.clear.cgColor {
        didSet {
            searchField.layer.borderColor = borderColor
        }
    }
    
    /// textField的边线颜色
    open var borderWidth: CGFloat = 0 {
        didSet {
            searchField.layer.borderWidth = borderWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 纯代码
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setupUI() {
        searchBar = SWSearchBar.init()
        self.addSubview(searchBar)
        searchBar.frame = self.bounds
        
        self.backgroundColor = .clear
        self.searchBar.delegate = self
        self.searchBar.placeholder = self.placeholder
        //1. 设置背景颜色
        //设置背景图是为了去掉上下黑线
        self.searchBar.backgroundImage = UIImage.init()
        // 设置SearchBar的颜色主题为白色
        self.searchBar.barTintColor = self.barTintColor
        //2. 设置圆角和边框颜色
        searchField = self.searchBar.value(forKey: "searchField") as? UITextField
        searchField.backgroundColor = self.searchFieldBgColor
        searchField.layer.borderColor = self.borderColor
        searchField.layer.borderWidth = self.borderWidth
        searchField.layer.cornerRadius = self.cornerRadius
        searchField.layer.masksToBounds = true
        // 设置按钮文字和颜色
        self.searchBar.sw_cancelButtonTitle(self.cancelTitle)
        // TODO:
        self.searchBar.tintColor = self.cancelTintColor
        // 设置取消按钮字体
        self.searchBar.sw_cancelButtonFont(self.cancelFont)
        //修正光标颜色
        searchField.tintColor = self.cursorTintColor
        // 设置输入框文字颜色和字体
        self.searchBar.sw_textColor(self.searchFieldColor)
        self.searchBar.sw_textFont(self.searchFieldFont)
        self.searchBar.setImage(UIImage.init(named: self.searchImage), for: UISearchBar.Icon.search, state: .normal)
    }

}

extension SWSearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.sw_searchBar(searchBar, textDidChange: searchText)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

class SWSearchBar: UISearchBar {
    func sw_textFont(_ font: UIFont) {
        (UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])).font = font
    }
    func sw_textColor(_ color: UIColor) {
        (UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])).textColor = color
    }
    func sw_cancelButtonTitle(_ title: String) {
        (UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])).title = title
    }
    func sw_cancelButtonFont(_ font: UIFont) {
        let textAttr = [kCTFontAttributeName :font]
        (UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])).setTitleTextAttributes(textAttr as [NSAttributedString.Key : Any], for: .normal)
    }
}
