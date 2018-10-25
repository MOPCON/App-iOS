//
//  QRCodeViewController.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/10/11.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit
import AVFoundation

protocol GetInteractionMissionResult: class {
    func updateMissionStatus()
}

class QRCodeViewController: UIViewController {
    
    var currentID: String?
    weak var getInteractionMissionResult:GetInteractionMissionResult?
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.scannerSetting()
        
 
    }
    
    func scannerSetting() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession.startRunning()
            
            initQRCodeFrame()
        } catch {
            
            print(error)
            return
        }
    }
    
    func initQRCodeFrame() {
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 5
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    func scannerAlert(message:String,isSuccess: Bool) {
        captureSession.stopRunning()
        let alertController = UIAlertController(title: "獲取條碼", message: "\(message)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            self.qrCodeFrameView?.removeFromSuperview()
            self.qrCodeFrameView = nil
            self.initQRCodeFrame()
            self.captureSession.startRunning()
        }
        
        alertController.addAction(cancelAction)
        
        if isSuccess {
            let okAction = UIAlertAction(title: "確認", style: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
                self.captureSession.stopRunning()
                self.getInteractionMissionResult?.updateMissionStatus()
            }
            alertController.addAction(okAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkQRCode(string:String) {
        guard let id = currentID else {
            return
        }
        let qrcodeID = qrCodeToID(qrcodeString: string)
        if id == qrcodeID {
            scannerAlert(message: "任務完成",isSuccess: true)
        } else {
            scannerAlert(message: "是不是跑錯攤位了？",isSuccess:  false)
        }
    }
    
    func qrCodeToID(qrcodeString:String) -> String {
        switch qrcodeString {
        case "U2FsdGVkX19kyWGqS+GgFkvU0mGfLzXl":
            return "m01"
        case "U2FsdGVkX1+8IpFMMITZ9xrsmFtjeDkv":
            return "m02"
        case "U2FsdGVkX19v7Fv5REEBkhcDCF6RT4bq":
            return "m03"
        case "U2FsdGVkX19O4Ze5Tmq8AepI/hyUhRn9":
            return "m04"
        case "U2FsdGVkX1+q8XBeRIPneXZkC84dhkCO":
            return "m05"
        case "U2FsdGVkX1+QgOPb07EpG/dTxRM3DuHy":
            return "m06"
        case "U2FsdGVkX18zg0FVQGig46aYXhY5J2/3":
            return "m07"
        case "U2FsdGVkX1+wXCoUqDaOcvUoM+q4gqdm":
            return "m08"
        case "U2FsdGVkX19dhRG6zRZ8qlQq+LBuJvS8":
            return "m09"
        case "U2FsdGVkX19OVe/IUimeZx3u9EASA5pu":
            return "m10"
        case "U2FsdGVkX1+bE63ByWKZPjiHvOU+VsDW":
            return "m11"
        case "U2FsdGVkX19EZl2bmT/6D/CDw3GGMrPI":
            return "m12"
        case "U2FsdGVkX19icQvCX4qtIXJaGX9y7YCv":
            return "m13"
        case "U2FsdGVkX1+RYWh2qJezpqIs8ykYu+Da":
            return "m14"
        case "U2FsdGVkX1+gt+3mo7BQthgXsJ2TZiTx":
            return "m15"
        case "U2FsdGVkX19F6ZYfZc/JB7loBGNGqBA0":
            return "m16"
        case "U2FsdGVkX1+cRsUjWfel00C6BCEo6Sc1":
            return "m17"
        case "U2FsdGVkX183r7fvqo1tXByhS0IreXTg":
            return "m18"
        case "U2FsdGVkX19G5WcSMhkTkFxBNTrPA5cs":
            return "m19"
        case "U2FsdGVkX1+ed8cGs99q1uv8gc1gXO/1":
            return "m20"
        case "U2FsdGVkX1/O+z8MQP2kcJxI9OcrNUsi":
            return "sp01"
        case "U2FsdGVkX19RnXp/NPxCjcftcS1ipxsT":
            return "sp11"
        case "U2FsdGVkX19E4qKAYeEhMyqfrLhG4kZp":
            return "sp02"
        case "U2FsdGVkX1/IuNFlODoUY69uZgyl/jC2":
            return "sp12"
        default:
            return "???"
        }
    }
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // 取得元資料（metadata）物件
        if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
            if metadataObj.type == AVMetadataObject.ObjectType.qr {
                // 倘若發現的元資料與 QR code 元資料相同，便更新狀態標籤的文字並設定邊界
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeFrameView?.frame = barCodeObject!.bounds
                
                if let string = metadataObj.stringValue {
                    print(qrCodeToID(qrcodeString: string))
                    checkQRCode(string: string)
                }
            }
        }
    }
    
}
