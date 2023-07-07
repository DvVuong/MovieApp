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
//        viewModel.fetchMessage()
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//            switch completion {
//            case .finished:
//                print("vuongdv completed fetch Message")
//            case .failure(let error):
//                print("vuongdv fetch message failure message with", error.localizedDescription)
//            }
//        } receiveValue: { [weak self] data in
//            guard let `self` = self  else {return}
//            self.dataSource.setupTableView(self.messageTableView, list: data)
//            self.messageTableView.reloadData()
//        }.store(in: &store)
        
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
        
        messageTableView.register(UINib(nibName: "ConvertionTableViewCell", bundle: nil), forCellReuseIdentifier: "ConvertionTableViewCell")
//        let m1 = MessageResponse(text: "abcasdasdasdasdasdasdasdasdasdasdasdasdasdasdqwdewfdweferferf",
//                                 time: 0,
//                                 nameSender: "",
//                                 senderAvatar: "",
//                                 idSender: "",
//                                 reciveName: "",
//                                 reciverAvatar: "",
//                                 idRecive: "",
//                                 imageurl: "")
//
//        var arr = [MessageResponse]()
//        arr.append(m1)
//
//        dataSource.setupTableView(messageTableView, list: arr)
    }
    
    override func setupTap() {
        backButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        photoButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        recordingButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        collapseButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTaButton(_:)), for: .touchUpInside)
        
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
        
    }
    
    private func openPhotoLibrabry() {
        
    }
    
    private func startRecoding() {
        
    }
    
    private func handelCollapse() {
        
    }
    
    private func sendMessage() {
        print("vuongdv SendMessage")
        viewModel.createMessage("Firts Message")
    }
    
}
