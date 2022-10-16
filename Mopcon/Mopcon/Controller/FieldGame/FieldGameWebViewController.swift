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
    
    private let userDefault: UserDefaults = UserDefaults()
    
    private let spinner = LoadingTool.setActivityindicator()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setWebView()
        
        startSpinner()
        
        startGame()
    }
        
    // MARK: URL Releate method
    private func setWebView() {
        
        gameWebView.navigationDelegate = self
        
        gameWebView.configuration.userContentController.add(self, name: "nativeApp")
        
        gameWebView.scrollView.showsVerticalScrollIndicator = false
        
        gameWebView.scrollView.showsHorizontalScrollIndicator = false
        
        gameWebView.isOpaque = false

        gameWebView.alpha = 0
    }
    
    private func startGame() {

        guard let url = URL(string: FieldGameProvider.baseURL) else { return }
        
        gameWebView.load(URLRequest(url: url))
    }
    
    private func startSpinner() {
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        view.addSubview(spinner)
    }
    
    private func stopSpinner() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.spinner.stopAnimating()
            
            self?.spinner.removeFromSuperview()
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, animations: {
            
                self?.gameWebView.alpha = 1
            })
        }
    }
    
    private func openQRCodeScanner() {
        
        let qrCodeViewController = QRCodeViewController()
                
        qrCodeViewController.getInteractionMissionResult = self
                
        let navigationController = UINavigationController(rootViewController: qrCodeViewController)
                
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true, completion: nil)
    }
    
    private func saveImageToAlbum(with base64: String) {
        
        if let image = base64.base64ToImage() {
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(openAlert(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    private func shareImage(with base64: String) {
        
        if let image = base64.base64ToImage() {
                
            let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)

            present(activity, animated: true)
        }
    }
    
    @objc private func openAlert(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    
        let message = error?.localizedDescription ?? "儲存圖片完成"
    
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
       
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Private userdefault method
    private func storePreference(preference: String) {
        
        Preference.store(preference)
    }
    
    private func loadPreference() -> String {
        
        return Preference.load()
    }
    
    // MARK: Private Call JS method
    private func sendDeviceIDToWeb() {
        
        guard let id = UIDevice.current.identifierForVendor?.uuidString else { return }
                
        gameWebView.evaluateJavaScript("getDeviceIDResponse('\(id)')", completionHandler: { (object, error) in
            
            print("completed with object, \(object ?? "")")

            print("completed with error, \(String(describing: error))")
        })
    }
    
    private func sendPreferenceToWeb(preference: String) {
                        
        gameWebView.evaluateJavaScript("loadPreferenceResponse('\(preference)')", completionHandler: { (object, error) in
            
            print("completed with object, \(object ?? "")")

            print("completed with error, \(String(describing: error))")
        })
    }
    
    private func sendQRCodeToWeb(qrCode:String) {

            gameWebView.evaluateJavaScript("onQRCodeScaned('{\"data\": \"\(qrCode)\"}')", completionHandler: { (object, error) in
            
            print("completed with object, \(object ?? "")")

            print("completed with error, \(String(describing: error))")
        })
    }
}


extension FieldGameWebViewController : WKNavigationDelegate {
    // MARK: WKNavigationDelegate method
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        print(#function)
    }
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        print(#function, error)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print(#function)
        
        stopSpinner()
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        print(#function,"error:",error)
    }
}


extension FieldGameWebViewController : WKScriptMessageHandler {
    
    // MARK: WKScriptMessageHandler method
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard let infos = message.body as? Dictionary<String, AnyObject>,
              let action = infos.keys.first,
              let value = infos.values.first
        else { return }
        
        switch action {
            
        case MPConstant.getDeviceID:
            
            print("MPConstant.getDeviceID")

            sendDeviceIDToWeb()
                        
        case MPConstant.loadPreference:
            
            print("MPConstant.loadPreference")
            
            sendPreferenceToWeb(preference: loadPreference())
                       
        case MPConstant.storePreference:
            
            print("MPConstant.storePreference")
                
            if let data = value["data"] as? Any {
                
                do {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    
                    if let preference = String(data: jsonData, encoding: String.Encoding.utf8) {
                                                
                        storePreference(preference: preference)
                    }
                    
                } catch {
                    
                    print(error)
                }
                
            }
            
        case MPConstant.scanQRCode:
            
            print("MPConstant.scanQRCode")
                        
            openQRCodeScanner()
            
        case MPConstant.socialShare:
                        
            print("MPConstant.socialShare")
            
            if let base64String = value["data"] as? String {
                
                shareImage(with: base64String)
            }
            
        case MPConstant.saveImage:
            
            print("MPConstant.saveImage")
         
            if let base64String = value["data"] as? String {
                
                saveImageToAlbum(with: base64String)
            }
            
        default:
            
            break
        }
    }
}

extension FieldGameWebViewController: GetInteractionMissionResult {
    
    func sendQRCode(value: String) {
       
        sendQRCodeToWeb(qrCode: value)
    }
}
