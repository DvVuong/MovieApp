//
//  MVPCamemraViewController.swift
//  MovieApp
//
//  Created by mr.root on 7/14/23.
//

import UIKit
import AVFoundation
import SnapKit
enum ChangeCamera: Int {
    case front
    case back
}

class MVPCamemraViewController: BaseViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var roleCamera: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var imotionButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var takeImageButton: UIImageView!
    @IBOutlet weak var viewBotton: UIView!
    @IBOutlet weak var viewSendImage: UIView!
    @IBOutlet weak var cancelSendButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    private var session: AVCaptureSession?
    private var output = AVCapturePhotoOutput()
    private let previewlayer = AVCaptureVideoPreviewLayer()
    private let picker = UIImagePickerController()
    private var changeCamere: ChangeCamera? = ChangeCamera.front
    
    public var handelImage: UIImage!
    public var sendButtonAction: ((UIImage) -> Void)? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.layer.addSublayer(previewlayer)
        setupTap()
        checkCameraPermission()
        setupGestureImage()
        image.isHidden = true
        viewSendImage.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewlayer.frame = view.bounds
    }
    
   override func setupTap() {
       cancelButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
       imotionButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
       roleCamera.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
       cancelSendButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
       sendButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    override func setupGestureImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        albumImage.isUserInteractionEnabled = true
        albumImage.addGestureRecognizer(gesture)
        let takePhotpGesture = UITapGestureRecognizer(target: self, action: #selector(takePhotoTapGesture(_:)))
        takeImageButton.isUserInteractionEnabled = true
        takeImageButton.addGestureRecognizer(takePhotpGesture)
    }
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined: // Không xác định
            AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
                guard granted else {return}
                DispatchQueue.main.async {
                    self?.openCamera()
                }
            }
        case .restricted: //Hạn chế
            break
        case .authorized: //uỷ quyền
            openCamera()
        case .denied:// từ chối
            break
        @unknown default:
            break
        }
    }
    
    private func openCamera() {
        let session = AVCaptureSession()
        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//        guard let cameraType = changeCamere else {return}
//        switch cameraType {
//        case .front:
//            let  frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
//        case .back:
//            let backCamera =  AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//        }
        do {
            let input = try AVCaptureDeviceInput(device: device!)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }

            previewlayer.connection?.automaticallyAdjustsVideoMirroring = false
            previewlayer.connection?.isVideoMirrored = true
            previewlayer.videoGravity = .resizeAspectFill
            previewlayer.session = session
            session.startRunning()
            self.session = session
        }
        catch {
            print(error)
        }
    }
    
    private func openPhotoLabrabri() {
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .overFullScreen
        self.present(picker, animated: true)
    }
    
    private func changCameraPosition() {
        
    }
    
    //MARK: -Action
    @objc private func takePhotoTapGesture(_ sender: UITapGestureRecognizer) {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
           openPhotoLabrabri()
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        if sender == cancelButton {
            pop()
        }else if sender == roleCamera {
            
        }else if sender == cancelSendButton {
            
        }else if sender == sendButton {
            sendButtonAction?(handelImage)
        }
    }
}

extension MVPCamemraViewController:  AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {return}
        DispatchQueue.main.async {
            self.image.image =  UIImage(data: data)
            self.image.isHidden = false
            self.session?.stopRunning()
            self.viewSendImage.isHidden = false
            self.viewBotton.isHidden = true
            self.handelImage = self.image.image ?? UIImage()
        }
    }
}
extension MVPCamemraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        picker.dismiss(animated: true)
        self.image.image = image
        self.handelImage = image
        self.image.isHidden = false
        self.viewBotton.isHidden = true
        self.viewSendImage.isHidden = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
