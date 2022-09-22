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

    var gameWebView : WKWebView? = nil

    let userDefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //////////////////////////////////////////////////

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        configuration.userContentController.add(self, name: "nativeApp")

        self.gameWebView = WKWebView(frame: self.view.frame, configuration: configuration)
        
        //Here you can customize configuration
   
        self.gameWebView?.uiDelegate = self
        self.gameWebView?.navigationDelegate = self

        guard let gameWebView = self.gameWebView else
        {
            return
        }

        self.view.addSubview(gameWebView)
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
        
            guard let url = URL(string: "https://game.mopcon.org/#/test")
            else
            {
                return
            }
                
            self.gameWebView?.load(URLRequest(url: url))
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
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Private Call JS method

    func sendDeviceIDToWeb()
    {
        guard let id = UIDevice.current.identifierForVendor?.uuidString
        else
        {
            return
        }
        
        let params = String(format: "getDeviceIDResponse('%@')", id)
        
        print(params)
        self.gameWebView?.evaluateJavaScript(params, completionHandler: { (object, error) in
                    print("completed with object, \(object)")
                    print("completed with error, \(error)")
        })
    }
    
    
    func sendPreferenceToWeb(preference:String)
    {
        self.gameWebView?.evaluateJavaScript("loadPreferenceResponse('\(preference)')", completionHandler: { (object, error) in
                    print("completed with object, \(object)")
                    print("completed with error, \(error)")
        })
    }
    
    
    func sendQRCodeToWeb(qrCode:String)
    {
        self.gameWebView?.evaluateJavaScript("onQRCodeScaned('\(qrCode)')", completionHandler: { (object, error) in
                    print("completed with object, \(object)")
                    print("completed with error, \(error)")
        })
    }
}


extension FieldGameWebViewController : WKNavigationDelegate
{
    // MARK: WKNavigationDelegate method

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function,error)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function,"error:",error)
    }
}


extension FieldGameWebViewController : WKScriptMessageHandler
{
    // MARK: WKScriptMessageHandler method
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // TODO: YourAction
        

        guard let infos = message.body as? Dictionary<String, AnyObject> else
        {
            return
        }
        
        
        let action = infos.keys.first!
        let value = infos.values.first!
        
        
        switch action
        {
            case MPConstant.getDeviceID:
                print("MPConstant.getDeviceID:",value)
                self.sendDeviceIDToWeb()
                break;
            case MPConstant.loadPreference:
                print("MPConstant.loadPreference:",value)
                self.sendPreferenceToWeb(preference: "211212121")
                break;
            
            case MPConstant.storePreference:
                print("MPConstant.storePreference:",value)
                break;
            
            case MPConstant.scanQRCode:
                print("MPConstant.scanQRCode:",value)
                self.sendQRCodeToWeb(qrCode: "31h3o12j3o123")
                break;
            
            case MPConstant.socialShare:
            print("MPConstant.socialShare:",value)
                break;
            
            case MPConstant.saveImage:
            print("MPConstant.saveImage:",value)
                break;
            
            default:
                break;
            
        }
    }
}


extension FieldGameWebViewController : WKUIDelegate
{
    
}
