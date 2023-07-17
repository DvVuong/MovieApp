////
////  ViewController.swift
////  Snapchat
////
////  Created by mr.root on 3/18/23.
////
//
//import UIKit
//import AVFoundation
//import SnapKit
//import RxSwift
//import RxCocoa
//enum ChangeCamera: Int {
//    case front
//    case back
//}
//class CustomCamera: UIViewController {
//    // Capture Session
//    private var session: AVCaptureSession?
//    //Photo input
//    private lazy var blnText = UILabel()
//
//    let output = AVCapturePhotoOutput()
//    // video Preview
//    let previewlayer = AVCaptureVideoPreviewLayer()
//    // Shutter button
//    private let shutterButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 0,
//                                            y: 0,
//                                            width:
//                                                50,
//                                            height: 50))
//        button.layer.cornerRadius = 25
//        button.layer.borderWidth = 1
//        button.layer.masksToBounds = true
//        return button
//    }()
//    
//    //var socket = SocketManager(coder: )
//    
//    private lazy var img = UIImageView()
//   
//    //Change front or back Camera
//    //private var cameraType = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
//    private lazy var btnChangeTypeCamera = UIButton()
//    private lazy var isChange: Bool = true
//    private var changeCamere: ChangeCamera? = ChangeCamera.front
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.backgroundColor = .black
//        view.layer.addSublayer(previewlayer)
//        view.addSubview(shutterButton)
//        checkCamerPermission()
//        setupButton()
//        btnChangeCameraAcction()
//        shutterButton.addTarget(self, action: #selector(didTapTakePhoto(_:)),
//                                for: .touchUpInside)
//        
//        let session = URLSession(configuration: .default,
//                                  delegate: self,
//                                  delegateQueue: OperationQueue())
//        let url = URL(string: "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")
//        webSocket = session.webSocketTask(with: url!)
//        webSocket?.resume()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        previewlayer.frame = view.bounds
//        
//        shutterButton.center = CGPoint(x: view.frame.size.width / 2,
//                                       y: view.frame.size.height - 50)
//    }
//    
//    private func setupButton() {
//        view.addSubview(btnChangeTypeCamera)
//        btnChangeTypeCamera.setTitle("ChangeCamera", for: .normal)
//        btnChangeTypeCamera.snp.makeConstraints { make in
//            make.bottom.equalTo(view.snp.bottom).offset(-50)
//            make.right.equalTo(view.snp.right).offset(-50)
//            make.width.height.equalTo(80)
//        }
//        
//        view.addSubview(img)
//        img.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
//            make.right.equalTo(view.snp.right).offset(-20)
//            make.width.equalTo(90)
//            make.height.equalTo(110)
//        }
//        
//        view.addSubview(blnText)
//        blnText.numberOfLines = 0
//        blnText.snp.makeConstraints { make in
//            make.top.equalTo(view.snp.top).offset(50)
//            make.width.equalTo(300)
//            make.height.equalTo(50)
//            make.centerX.equalTo(view.snp.centerX)
//        }
//    }
//    
//    private func btnChangeCameraAcction() {
//        btnChangeTypeCamera
//            .rx
//            .tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner,_ in
//                let vc = VideoCallViewController()
//                vc.modalPresentationStyle = .overFullScreen
//                owner.present(vc, animated: true)
//                owner.closes()
//                owner.isChange = !owner.isChange
//                if owner.isChange {
//                    owner.changeCamere = ChangeCamera.front
//                    debugPrint(owner.isChange)
//                } else {
//                    owner.changeCamere = ChangeCamera.back
//                    debugPrint(owner.isChange)
//                }
//                owner.setupCamera()
//            })
//            .disposed(by: bag)
//        
//    }
//    
//    private func checkCamerPermission() {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .notDetermined: // Không xác định
//            AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
//                guard granted else {return}
//                DispatchQueue.main.async {
//                    self?.setupCamera()
//                }
//            }
//        case .restricted: //Hạn chế
//            break
//        case .authorized: //uỷ quyền
//            setupCamera()
//        case .denied:// từ chối
//            break
//        @unknown default:
//            break
//        }
//    }
//    
//    private func setupCamera() {
//        let session = AVCaptureSession()
//        var device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//        guard let cameraType = changeCamere else {return}
//        switch cameraType {
//        case .front:
//           let  frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
//           // debugPrint("Camera Trước")
//        case .back:
//            let backCamera =  AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//            //debugPrint("Camera Sau")
//        }
//        do {
//            let input = try AVCaptureDeviceInput(device: device!)
//            if session.canAddInput(input) {
//                session.addInput(input)
//            }
//            if session.canAddOutput(output) {
//                session.addOutput(output)
//            }
//
//            previewlayer.connection?.automaticallyAdjustsVideoMirroring = false
//            previewlayer.connection?.isVideoMirrored = true
//            previewlayer.videoGravity = .resizeAspectFill
//            previewlayer.session = session
//            session.startRunning()
//            self.session = session
//        }
//        catch {
//            print(error)
//        }
//    }
//    
//    func ping() {
//        webSocket?.sendPing{error in
//            if let error = error {
//                print(error)
//            }
//            
//        }
//    }
//    
//    func closes() {
//        webSocket?.cancel(with: .goingAway, reason: "Done demo".data(using: .utf8))
//        webSocket?.closeReason
//    }
//    
//    func send() {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//            self.send()
//            self.webSocket?.send(.string("Send new Message: \(Int.random(in: 0...100))"),
//                            completionHandler: {error in
//                if let error = error {
//                    print(" send error: \(error)")
//                }
//            })
//        }
//    }
//    
//    func recevie() {
//        webSocket?.receive(completionHandler: {result in
//            switch result {
//            case .success(let message):
//                switch message {
//                case .data(let data):
//                    print("data: \(data)")
//                case .string(let message):
////                    DispatchQueue.main.async {
////                        self.blnText.text = message
////                    }
//                    print("message: \(message)")
//                @unknown default:
//                    break
//                }
//            case .failure(let error):
//                print(error)
//            }
//            self.recevie()
//        })
//    }
//    
//    @objc private func didTapTakePhoto(_ sender: UIButton) {
//        output.capturePhoto(with: AVCapturePhotoSettings(),
//                            delegate: self)
//        
//        
//        
//    }
//
//
//}
//extension ViewController: AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
//    
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        guard let data = photo.fileDataRepresentation() else {
//            return
//        }
//        //debugPrint("DidFinishProcessingPhoto")
//        DispatchQueue.main.async {
//            self.img.image = UIImage(data: data)
//        }
//       // session?.stopRunning()
//    }
//    
//    
////    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
////        <#code#>
////    }
//    
//    
//}
//extension ViewController: URLSessionWebSocketDelegate {
//    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
//        debugPrint("Did connetion to socket")
//        ping()
//        recevie()
//        send()
//
//    }
//    
//    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
//        debugPrint("close connetion to socket")
//        closes()
//    }
//    
//}
//
//
//
