import UIKit
import AVFoundation
import AVKit


//http://stackoverflow.com/questions/2504151/calayers-didnt-get-resized-on-its-uiviews-bounds-change-why
class LayoutPlayerView:UIView{
    
    weak var playerLayer:AVPlayerLayer?
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.playerLayer?.frame = self.bounds;
    }
    
    func configureLayer(playerLayer:AVPlayerLayer){
        self.layer.addSublayer(playerLayer)
        self.playerLayer = playerLayer
    }
}
