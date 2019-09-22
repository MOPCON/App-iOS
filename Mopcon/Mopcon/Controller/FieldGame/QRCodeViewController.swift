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

class QRCodeViewController: MPBaseViewController {
    
    var taskID: String?
        
    weak var getInteractionMissionResult: GetInteractionMissionResult?
    
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var qrCodeFrameView: UIView?
    
    private var isScanned: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpUI()

        scannerSetting()
    }
    
    
    private func setUpUI() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.title = "QR Code"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.asset(.close), style: .plain, target: self, action: #selector(dismissAction))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.barTintColor = .dark
    }
    
    private func scannerSetting() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
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
            
            print("Camera Error: \(error)")
            
            return
        }
    }
    
    private func initQRCodeFrame() {
        
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            
            qrCodeFrameView.layer.borderWidth = 5
            
            view.addSubview(qrCodeFrameView)
            
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    private func scannerAlert(message:String) {
        
        isScanned = false
                
        let alertTitle = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "通知" : "Info"
        
        let alertController = UIAlertController(title: alertTitle, message: "\(message)", preferredStyle: .alert)
        
        let cancelString = (CurrentLanguage.getLanguage() == Language.chinese.rawValue) ? "取消" : "Cancel"
        
        let cancelAction = UIAlertAction(title: cancelString, style: .cancel)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func checkQRCode(vKey: String) {
                    
        isScanned = true
        
        guard let taskID = self.taskID else { return }
        
        FieldGameProvider.verify(with: .task, and: taskID, and: vKey, completion: { [weak self] result in
            
            switch result {
            
            case .success(_):
                
                self?.dismiss(animated: true, completion: {

                    self?.getInteractionMissionResult?.updateMissionStatus()
                })
            
            case .failure(let error):
            
                self?.scannerAlert(message: error.localizedDescription)
            }
        })
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard !isScanned else { return }
        
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
                    
                    checkQRCode(vKey: string)
                }
            }
        }
    }
    
}
