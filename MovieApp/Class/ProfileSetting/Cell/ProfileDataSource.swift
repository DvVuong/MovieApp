//
//  ProfileDataSource.swift
//  MovieApp
//
//  Created by BeeTech on 16/06/2023.
//

import UIKit

class ProfileDataSource: UITableViewController {
    
    public var handelAction: (() -> Void)? = nil
    enum Celltype {
        case logOut
    }
    
    var sections: [Celltype] = [
        .logOut
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .logOut:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.titelLabel.text = "Logout"
        cell.handelButton = { [weak self]  in
            guard let `self` = self else { return }
            self.handelAction?()
        }
        return cell
    }
}
