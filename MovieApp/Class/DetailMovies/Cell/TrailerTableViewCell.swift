//
//  TrailerTableViewCell.swift
//  MovieApp
//
//  Created by mr.root on 8/7/23.
//

import UIKit
import WebKit
import SnapKit
import youtube_ios_player_helper

class TrailerTableViewCell: UITableViewCell {
    
    static var indentifer = "TrailerTableViewCell"
    
    private lazy var playerView: YTPlayerView = {
       let view = YTPlayerView()
        view.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
        updateConstraintsIfNeeded()
    }
    
    func bindData(with videoID: Video ) {
        playerView.load(withVideoId: videoID.key ?? "")
    }
}

extension TrailerTableViewCell: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
       // playerView.playVideo()
    }
}
