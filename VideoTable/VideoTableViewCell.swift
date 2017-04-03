//
//  VideoTableViewCell.swift
//  VideoTable
//
//  Created by ioshero on 28.03.17.
//  Copyright © 2017 ioshero. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var UserImageView: UIImageView!
    
    @IBOutlet weak var AuthorButton: UIButton!
    @IBOutlet weak var PlayerView: UIView!
    
    var avLayer: AVPlayerLayer = AVPlayerLayer.init()
    var avPlayer: AVPlayer = AVPlayer.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func AuthorButtonClick(_ sender: UIButton) {
    }
}
