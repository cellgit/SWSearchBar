//
//  SWTabBarViewController.swift
//  SWSearchBar
//
//  Created by Alan on 2019/9/21.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

struct SWTabBarStruct {
    var title: String = ""
    var imageName: String = ""
    var vc: UIViewController!
}

class SWTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    }
    

    func addChildViewControllers() {
        let first = SWTabBarStruct.init(title: "PageViewController", imageName: "", vc: SWHomeViewController())
        let array = [first]
        var arrayM = [UIViewController]()
        for item in array {
            arrayM.append(self.childControllers(params: item))
        }
        self.viewControllers = arrayM
    }
    
    func childControllers(params: SWTabBarStruct) -> UIViewController{
        let vc: UIViewController = params.vc
        vc.title = params.title
        let imageName = "tabbar_icon_\(params.imageName)_normal"
        vc.tabBarItem.image = UIImage.init(named: imageName)
        let imageNameHL = "tabbar_icon_\(params.imageName)_highlight"
        vc.tabBarItem.selectedImage = UIImage.init(named: imageNameHL)?.withRenderingMode(.alwaysOriginal)
        let nav = UINavigationController.init(rootViewController: vc)
        return nav
    }

}
