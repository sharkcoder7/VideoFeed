//
//  PlayerView.swift
//  VideoTable
//
//  Created by Admin on 30.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    init(player : AVPlayer, playerLayer: AVPlayerLayer) {
        super.init()
        self.player = player
        self.playerLayer = playerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        get {
            return self.playerLayer
        }
        set {
            self.playerLayer = newValue
        }
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

}
