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


let kUpdateVideoCell = NSNotification.Name("kUpdateVideoCell")
let kPlayNext = NSNotification.Name("kPlayNext")

class Notificator {
    static func fireNotification(named: NSNotification.Name) {
        NotificationCenter.default.post(name: named, object: nil)
    }
}


var currentlyPlayingIndex:IndexPath = IndexPath(row:0,section:0)

extension AVPlayer {
    
    func isPlaying() -> Bool {
        
        return (self.rate != 0.0 && self.status == .readyToPlay)
    }
}


extension VideoTableViewCell{
    
    func listenForPlayerChanges(){
        NotificationCenter.default.removeObserver(self, name: kUpdateVideoCell, object: nil)
        NotificationCenter.default.addObserver(forName:kUpdateVideoCell, object: nil, queue: OperationQueue.main, using: { (note) in
            print("update cell")
            if(currentlyPlayingIndex == self.indexPath){
                self.isOrWasPlaying = true
                print("Playing video at index :",  self.indexPath);
                self.avPlayer.play()
//                self.backgroundColor = .black
//                self.contentView.backgroundColor = .black
                self.avPlayer.volume = 1
    
            }else{
                if(self.isOrWasPlaying){
                    self.isOrWasPlaying = false
                    self.fadeOutSound()
                }
                self.avPlayer.pause()
//                self.backgroundColor = .yellow
//                self.contentView.backgroundColor = .yellow
            }

        })
    }
    

    
    // TODO - doesn't seem to work
    func fadeInSound() {
        self.avPlayer.volume = 0
        UIView.animate(withDuration: 1.0, animations: { 
            self.avPlayer.volume = 1
        })
    }
    
    func fadeOutSound() {
        UIView.animate(withDuration: 1.0, animations: {
            self.avPlayer.volume = 0
        })
        
    }
    
}

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var AuthorButton: UIButton!
    @IBOutlet weak var playerView: LayoutPlayerView!
    
    var isOrWasPlaying = false
    
    var indexPath:IndexPath = IndexPath(row:0,section:0)

    var avPlayer: AVPlayer = AVPlayer.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makePlayerLoop(){
        NotificationCenter.default.removeObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            if(self.avPlayer.isPlaying() || self.isOrWasPlaying){
                self.isOrWasPlaying = false
                self.avPlayer.seek(to: kCMTimeZero)
                self.avPlayer.pause()
                Notificator.fireNotification(named: kPlayNext)
            }
        }
        
    }

    @IBAction func AuthorButtonClick(_ sender: UIButton) {
    }
}
