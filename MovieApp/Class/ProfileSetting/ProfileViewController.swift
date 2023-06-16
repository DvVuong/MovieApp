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
    private var subcriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUser()
        setupUI()
        setupViewModel()
    }
    
   override func setupUI() {
       avatarUser.cornerRadius(avatarUser.frame.size.height / 2)
    }
    
    override func setupViewModel() {
        viewModel.userPublisher.sink { [weak self] userData in
            guard let `self` = self else { return }
            self.nameLabel.text = userData.userName ?? ""
        }
        .store(in: &subcriptions)
    }

}
