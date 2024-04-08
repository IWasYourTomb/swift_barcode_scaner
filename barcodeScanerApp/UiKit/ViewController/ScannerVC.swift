//
//  ScanerVC.swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import UIKit
import AVFoundation


protocol ScannerVCDelegate: AnyObject{
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

final class ScanerVC: UIViewController{
    let captureSessing = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scanerDelegate: ScannerVCDelegate!
    
    init(scanerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scanerDelegate = scanerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else{
            scanerDelegate?.didSurface(error: .InvalidDeviceInput)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
            scanerDelegate?.didSurface(error: .InvalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch{
            scanerDelegate?.didSurface(error: .InvalidDeviceInput)
            return
        }
        
        if captureSessing.canAddInput(videoInput){
            captureSessing.addInput(videoInput)
        }else{
            scanerDelegate?.didSurface(error: .InvalidDeviceInput)
            return
        }
        
        let metaDataOutput  = AVCaptureMetadataOutput()
        
        if captureSessing.canAddOutput(metaDataOutput){
            captureSessing.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        }else{
            scanerDelegate?.didSurface(error: .InvalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSessing)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSessing.startRunning()
    }
}

extension ScanerVC: AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else{
            scanerDelegate?.didSurface(error: .invalidScanValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else{
            scanerDelegate?.didSurface(error: .invalidScanValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else{
            scanerDelegate?.didSurface(error: .invalidScanValue)
            return
        }
        
       
        scanerDelegate?.didFind(barcode: barcode)
    }
}
