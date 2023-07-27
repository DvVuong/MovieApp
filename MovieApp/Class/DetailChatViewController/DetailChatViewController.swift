//
//  DetailChatViewController.swift
//  MovieApp
//
//  Created by mr.root on 7/2/23.
//

import UIKit
import Combine

class DetailChatViewController: BaseViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var stateLable: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var collapseButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var heightContrainsBottomView: NSLayoutConstraint!
    @IBOutlet weak var heigthContrainViewBottom: NSLayoutConstraint!
    
    private let imagePickerViewControll = UIImagePickerController()
    private let dataSource: DetailDataSource = DetailDataSource()
    private let viewModel: DetailChatViewModel = DetailChatViewModel()
    private var store = Set<AnyCancellable>()
    convenience init(reciverUser: UserResponse) {
        self.init()
        viewModel.reciverUserPassthroughSubject.send(reciverUser)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        avatarImage.cornerRadius(avatarImage.frame.size.height / 2)
        avatarImage.setupBoderWidth(with: 1, color: UIColor.black.cgColor)
        stateImage.cornerRadius(stateImage.frame.size.height / 2)
        stateImage.setupBoderWidth(with: 2, color: UIColor.white.cgColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        viewModel.fetchMessage()
    }
    
    override func setupViewModel() {
        viewModel.message.sink(receiveValue: {[weak self] data in
            guard let `self` = self else {return}
            self.dataSource.setupTableView(self.messageTableView, list: data ?? [])
            self.messageTableView.reloadData()
        }).store(in: &store)
    }
    
    private func setupTableView() {
        messageTableView.delegate = dataSource
        messageTableView.dataSource = dataSource
        messageTableView.separatorStyle = .none
        messageTableView.estimatedRowHeight = UITableView.automaticDimension
        messageTableView.register(UINib(nibName: "ConvertionTableViewCell", bundle: nil), forCellReuseIdentifier: "ConvertionTableViewCell")
        messageTableView.register(UINib(nibName: "ReciverUserTableViewCell", bundle: nil), forCellReuseIdentifier: "ReciverUserTableViewCell")
        messageTableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }
    
    override func setupTap() {
        backButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        photoButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        recordingButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        collapseButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
    }
    
    private func scrollToBotton() {
        DispatchQueue.main.async {
            if self.viewModel.getItem() < 1  {return}
            let indexPath = IndexPath(row: self.viewModel.getItem() - 1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc private func didTaButton(_ sender: UIButton) {
        if sender === backButton {
            self.pop()
        }else if sender === cameraButton {
            self.openCamera()
        }else if sender === photoButton {
            self.openPhotoLibrabry()
        }else if sender === recordingButton {
            self.startRecoding()
        }else if sender === collapseButton {
            self.handelCollapse()
        }else if sender === sendButton {
            sendMessage()
        }
    }
    
    private func openCamera() {
        let vc = MVPCamemraViewController()
        vc.sendButtonAction = {[weak self] image in
            guard let `self` = self else {return}
            let messageType = MessageType(type: 1)
//            self.viewModel.createMessgaeWithImage(with: image, messageType: messageType)
        }
        vc.deleagte = self
        push(vc)
    }
    
    private func openPhotoLibrabry() {
        let vc = MVPCamemraViewController()
        vc.openPhotoLibrabry = true
        push(vc)
    }
    
    private func startRecoding() {
        
    }
    
    private func handelCollapse() {
        
    }
    
    private func sendMessage() {
        let messageType = MessageType(type: 0)
        if textView.text == "" {
            sendButton.setImage(Asset.icHeart.image, for: .normal)
            scrollToBotton()
        } else {
            viewModel.createMessage(textView.text, messagetye: messageType)
            textView.text = ""
            scrollToBotton()
        }
    }
}


extension DetailChatViewController {
    override func keyBoardWillShow(_ sender: Notification) {
        let keyboardframe = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]! as! NSValue).cgRectValue.height
        self.heigthContrainViewBottom.constant = -(keyboardframe)
        scrollToBotton()
        self.view.layoutIfNeeded()
    }
    override func keyBoardWillHide(_ sender: Notification) {
        self.heigthContrainViewBottom.constant = view.safeAreaInsets.bottom
        self.view.layoutIfNeeded()
    }
}

extension DetailChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  else {return}
        self.imagePickerViewControll.dismiss(animated: true)
        let messageType = MessageType(type: 1)
//        self.viewModel.createMessgaeWithImage(with: messageType)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerViewControll.dismiss(animated: true)
    }
}
extension DetailChatViewController: MVPCamemraViewControllerDelegate {
    func didChooseImage(with messages: [UIImage]) {
        print("vuongdv \(messages.count)")
    }
}
