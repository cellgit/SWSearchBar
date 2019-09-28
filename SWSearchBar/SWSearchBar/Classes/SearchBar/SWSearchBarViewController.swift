//
//  SWSearchBarViewController.swift
//  SWSearchBar
//
//  Created by Alan on 2019/9/21.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit
import AuthenticationServices

class SWSearchBarViewController: UIViewController {
    let kScreenWidth = UIScreen.main.bounds.size.width
    let kScreenHeight = UIScreen.main.bounds.size.height
    
    let kOffset: CGFloat = 100
    let kSignInBtnHeight: CGFloat = 100
    
    
    let kPadding: CGFloat = 16
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.view.backgroundColor = .secondarySystemBackground
        } else {
            // User Interface is Light
            self.view.backgroundColor = .white
        }
        
//        self.title = " Sign In With Apple"
        setupUI()
        
        setAignInWithApple()
    }
    func setupUI() {
        let searchBarView = SWSearchBarView.init(frame: CGRect(x: kPadding, y: 200, width: self.view.bounds.width - kPadding*2*2, height: 38))
        self.navigationItem.titleView = searchBarView   // 添加到navigation
        self.view.addSubview(searchBarView) //添加到普通view
        searchBarView.delegate = self
        searchBarView.placeholder = " 请Google 'Sign in with Apple'"
    }
    
    func setAignInWithApple() {
        let frame = CGRect(x: kOffset / 2, y: 150, width: kScreenWidth - kOffset, height: kSignInBtnHeight/1.5)
        let btn = ASAuthorizationAppleIDButton.init(type: .signIn, style: .white)
        btn.frame = frame
//        btn.cornerRadius = kSignInBtnHeight / 4
        
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    
    @objc func signIn() {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        let appleIDProvider = ASAuthorizationAppleIDProvider.init()
        // 创建新的AppleID 授权请求
        let appleIDRequest = appleIDProvider.createRequest()
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = [.fullName, .email]
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        let authorizationController = ASAuthorizationController.init(authorizationRequests: [appleIDRequest])
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self
        // 在控制器初始化期间启动授权流
        authorizationController.performRequests()
    }
    
    
    /*
     已经使用Sign In with Apple登录过app的用户
     如果设备中存在iCloud Keychain凭证或者AppleID凭证，提示用户直接使用TouchID或FaceID登录即可，代码如下
     */
    func perfomExistingAccountSetupFlows() {
        let appleIDProvider = ASAuthorizationAppleIDProvider.init()
        let appleIDRequest = appleIDProvider.createRequest()
        // 为了执行钥匙串凭证分享生成请求的一种机制
        let passwordProvider = ASAuthorizationPasswordProvider.init()
        
        let passwordRequest = passwordProvider.createRequest()
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        let authorizationController = ASAuthorizationController.init(authorizationRequests: [appleIDRequest, passwordRequest])
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self
        // 在控制器初始化期间启动授权流
        authorizationController.performRequests()
    }
    
    
}

/// 处理授权登录成功和失败
extension SWSearchBarViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("授权完成authorization.credential===== \(authorization.credential)")
        print("controller===== \(controller)")
        print("authorization===== \(authorization)")
        
        let mStr = NSMutableString.init()
        print("mStr")
        if authorization.credential.isKind(of: ASAuthorizationAppleIDCredential.self) {
            
            // 用户登录使用ASAuthorizationAppleIDCredential
            let appleIDCredential: ASAuthorizationAppleIDCredential = authorization.credential as! ASAuthorizationAppleIDCredential
            let user: String = appleIDCredential.user
            
            let familyName = appleIDCredential.fullName?.familyName
            let givenName = appleIDCredential.fullName?.givenName
            let email = appleIDCredential.email
            
//            YostarKeychain
        }
        else if authorization.credential.isKind(of: ASPasswordCredential.self) {
            // 用户登录使用现有的密码凭证
            let passwordCredential: ASPasswordCredential = authorization.credential as! ASPasswordCredential
            // 密码凭证对象的用户标识 用户的唯一标识
            let user: String = passwordCredential.password
            // 密码凭证对象的密码
            let password = passwordCredential.password
            mStr.append(user)
            mStr.append("\n")
            mStr.append(password)
            mStr.append("\n")
            print("(mStr)==== \(mStr)")
        }
        else {
            print("授权信息均不符")
            
            print("授权信息均不符 \(mStr)")
        }
    }
    /// 授权失败的回调
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("controller===== \(controller)")
        print("error===== \(error)")
        var errorMsg: String = ""
//        switch error {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
        
    }
}
/// 提供用于展示授权页面的Window
extension SWSearchBarViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        //
        print("self.view.window")
        return self.view.window ?? ASPresentationAnchor.init()
    }
}



//// 授权失败的回调
//- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error{
//    // Handle error.
//    NSLog(@"Handle error：%@", error);
//    NSString *errorMsg = nil;
//    switch (error.code) {
//        case ASAuthorizationErrorCanceled:
//            errorMsg = @"用户取消了授权请求";
//            break;
//        case ASAuthorizationErrorFailed:
//            errorMsg = @"授权请求失败";
//            break;
//        case ASAuthorizationErrorInvalidResponse:
//            errorMsg = @"授权请求响应无效";
//            break;
//        case ASAuthorizationErrorNotHandled:
//            errorMsg = @"未能处理授权请求";
//            break;
//        case ASAuthorizationErrorUnknown:
//            errorMsg = @"授权请求失败未知原因";
//            break;
//
//        default:
//            break;
//    }
    
//    NSMutableString *mStr = [_appleIDInfoLabel.text mutableCopy];
//    [mStr appendString:@"\n"];
//    [mStr appendString:errorMsg];
//    [mStr appendString:@"\n"];
//    _appleIDInfoLabel.text = mStr;
//}

// 告诉代理应该在哪个window 展示内容给用户
//- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller{
//    NSLog(@"88888888888");
//    // 返回window
//    return self.view.window;
//}





extension SWSearchBarViewController: SWSearchBarDelegate {
    func sw_searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText ===== \(searchText)")
    }
}
