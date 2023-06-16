//
//  ProfileDataSource.swift
//  MovieApp
//
//  Created by BeeTech on 16/06/2023.
//

import UIKit

class ProfileDataSource: UITableViewController {
    private enum Celltype {
        case logOut
    }
    
    var sections: [Celltype] = {
        .logOut
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .logOut:
            return 1
        }
    }
}
