//
//  FieldGameWebViewController.swift
//  Mopcon
//
//  Created by Yang Tun-Kai on 2022/9/13.
//  Copyright © 2022 EthanLin. All rights reserved.
//

import UIKit
import WebKit

class FieldGameWebViewController: UIViewController {

    @IBOutlet weak var gameWebView: WKWebView!
    
    let userDefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.startGame()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: URL Releate method
    
    func startGame(){
        let token = getToken()
        
        if(token.count<=0)
        {
            
        }
        else
        {
            
        }
     
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Private userdefault method

    func saveToken(token:String){
        userDefault.setValue(token, forKey: MPConstant.webGameTokenKey)
    }
    
    func getToken()->String{
        guard let token = userDefault.value(forKey: MPConstant.webGameTokenKey) as? String else {
            return ""
        }
        return token
    }
    

    
}


extension FieldGameWebViewController : WKNavigationDelegate
{
    // MARK: WKNavigationDelegate method

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
}


extension FieldGameWebViewController : WKScriptMessageHandler
{
    // MARK: WKScriptMessageHandler method
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // TODO: YourAction
        print("message",message)
        
    }
}
