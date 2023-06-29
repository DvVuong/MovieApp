//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/11/23.
//

import UIKit
import Combine

class ProfileViewController: BaseViewController {
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: ProfileViewModel = ProfileViewModel()
    private let dataSource: ProfileDataSource = ProfileDataSource()
    private var subcriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUser()
        setupUI()
        setupViewModel()
        setupTableView()
        onBind()
    }
    
    override func onBind() {
        viewModel.dosomething.sink { text in
            ToastUtil.showToast(with: text ?? "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.popToVC(LoginViewController())
                self.pop()
            }
            
        }.store(in: &subcriptions)
    }
    
    private func setupTableView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
   override func setupUI() {
       avatarUser.cornerRadius(avatarUser.frame.size.height / 2)
    }
    
    override func setupTap() {
        dataSource.handelAction = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.logoutUser()
        }
    }
    
    override func setupViewModel() {
        viewModel.userPublisher.sink { [weak self] userData in
            guard let `self` = self else { return }
            self.nameLabel.text = userData.userName ?? ""
        }
        .store(in: &subcriptions)
    }

}
