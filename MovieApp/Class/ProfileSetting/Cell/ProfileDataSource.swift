//
//  ProfileDataSource.swift
//  MovieApp
//
//  Created by BeeTech on 16/06/2023.
//

import UIKit


struct SettingItem {
    var title: String?
}
protocol ProfileDataSourceDelegate: AnyObject {
   func didChooseUser()
    func didChooseSetting()
    func didChooseLogout()
}
class ProfileDataSource: UITableViewController {
    
    public var handelAction: (() -> Void)? = nil
    weak var delegate: ProfileDataSourceDelegate?
    enum Celltype {
        case logOut(models: SettingItem)
        case setting(models: SettingItem)
        case user(models: SettingItem)
    }
    var sections: [Celltype] = [
        .user(models: SettingItem(title: "User")),
        .setting(models: SettingItem(title: "Setting")),
        .logOut(models: SettingItem(title: "Logout"))
        
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .user(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.bindData(with: item.title)
            cell.accessoryType = .disclosureIndicator
            return cell
            
        case .setting(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.bindData(with: item.title)
            cell.accessoryType = .disclosureIndicator
            return cell
            
        case .logOut(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.bindData(with: item.title)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .user(_):
            delegate?.didChooseUser()
        case .setting(_):
            delegate?.didChooseSetting()
        case .logOut(_):
            delegate?.didChooseLogout()
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
