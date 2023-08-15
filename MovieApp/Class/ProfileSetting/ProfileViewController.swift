//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by mr.root on 6/11/23.
//

import UIKit
import Combine

class ProfileViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        return tableView
    }()
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
        conficgureNavi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func conficgureNavi() {
        self.navigationController?.navigationBar.topItem?.title = "Setting"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func onBind() {

    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
        dataSource.delegate = self
    }

    override func setupTap() {
    }
    
    override func setupViewModel() {
       
    }
    
    private func showAlert(with message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Log out", style: .default) { _ in
            completion?()
        }
        let cancelAcction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAcction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileDataSourceDelegate {
    func didChooseSetting() {
        print("Vuongdv Setting")
    }
    
    func didChooseUser() {
        print("Vuongdv User")
    }
    
    func didChooseLogout() {
        showAlert(with: "Do you want to Log out?") {[weak self] in
            guard let `self` = self else {return}
            self.viewModel.logoutUser() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = LoginViewController()
                    vc.hidesBottomBarWhenPushed = true
                    self.push(vc)
                }
            }
        }
    }
}
