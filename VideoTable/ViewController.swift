//
//  ViewController.swift
//  VideoTable
//
//  Created by ioshero on 28.03.17.
//  Copyright © 2017 ioshero. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    // variables
    var urls : NSMutableArray = []
    var visibleIndex:Int = 0
    var videoHeight:Float = 0.0
    
    var cache: NSMutableDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "VideoCellView", bundle: nil), forCellReuseIdentifier: "VideoCell")
        
        // init constants

        // init variables
        cache = [:]
        visibleIndex = 0
        
        // init URLs
        urls = ["https://vziptvapi.azurewebsites.net/assets/stream/output/VZ_Kevin_Hart.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/VZ_reConnect.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/VZ_Fear.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/VZ_NFL.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/VZ_Marching_Band.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/transformers%20dark%20of%20the%20moon%20(2011).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/Everyday.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/real%20steel%20(2011).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/In%20The%20Loop.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/iron%20man%203%20(2013).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/nba.2013.03.27.chicago.bulls.vs.miami.heat.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/the%20hobbit%20an%20unexpected%20journey%20(2012).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/sherlock%20holmes%20a%20game%20of%20shadows%20(2012).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/one%20for%20the%20money%20(2012).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/fa.cup.2013.04.01.chelsea.vs.manchester.united.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/kung%20fu%20panda%202%20(2011).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/ufc.on.fx.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/ncaa.football.2012.09.15.alabama.vs.arkansas.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/super%208%20(2011).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/Game%20of%20Thrones.S03E01.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/sportscenter.year.in.review.2010.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/the%20amazing%20spider-man%20(2012).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/nfl.afc.championship.2013.01.20.ravens.vs.patriots.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/300%20-%20Rise%20of%20an%20Empire%20(2014).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/hbo.boxing.pacquaio.vs.bradley.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/the%20adventures%20of%20tintin%20(2011).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/mlb.2012.08.07.tigers.vs.yankees.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/nhl.2013.02.24.avalanche.vs.ducks.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/the%20avengers%20(2012).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/mission%20impossible%20-%20ghost%20protocol%20(2011).mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/Psych.S06E01.mp4.m3u8",
             "https://vziptvapi.azurewebsites.net/assets/stream/output/tron%20legacy%20(2010).mp4.m3u8"]
		
        // calculate video height
        videoHeight = 0.0
		
        for item in urls {
            let asset = AVURLAsset(url: URL(fileURLWithPath: item as! String))
            let tracks = asset.tracks(withMediaType: AVMediaTypeVideo)
            if (tracks.count > 0) {
                let track = tracks[0]
                let mediaSize = track.naturalSize
                let size = Float ((view.frame.size.width * mediaSize.height)/mediaSize.width) + 100.0
                if (size > videoHeight) {
                    videoHeight = size
                }
            }
        }
		
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(300.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let simpleTableIdentifier = "VideoCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        let newCell: VideoTableViewCell
        if cell == nil {
            cell = VideoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: simpleTableIdentifier)
            newCell = cell as! VideoTableViewCell
        } else {
            newCell = cell as! VideoTableViewCell
        }
        
        // get url
        let url = NSURL(string: urls[indexPath.row] as! String)
               
        let avLayer = cache.object(forKey: String(indexPath.row))
        let newLayer: AVPlayerLayer
        if avLayer == nil {
            let videoPlayer = AVPlayer(url: url as! URL)
            let avLayer = AVPlayerLayer(player: videoPlayer)
			
            cache.setObject(avLayer, forKey: String(indexPath.row) as NSCopying)
            newLayer = avLayer
        } else{
            newLayer = avLayer as! AVPlayerLayer
        }
        
        // refresh layer
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.sync {
                // Causing some flicker due to old layer being removed and new layer being added
                // TODO : perform video load in this
            }
        }
        
        newCell.PlayerView.layer.sublayers=nil;
        newLayer.frame = newCell.PlayerView.bounds
        newCell.PlayerView.layer.addSublayer(newLayer)
        newCell.avLayer = newLayer
        newCell.avPlayer = newCell.avLayer.player!
        newCell.avPlayer.pause()
        
        if(visibleIndex == indexPath.row){
            NSLog("Playing video at index : %ld", visibleIndex);
            newCell.avPlayer.play()
            loopVideo(videoPlayer: newCell.avPlayer)
        }
        newCell.selectionStyle = UITableViewCellSelectionStyle.none
        newCell.tag = indexPath.row
        
        return newCell;
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            visibleIndex = -1;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetVisibleIndex()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(!decelerate){
            resetVisibleIndex()
        }
    }
    
    func resetVisibleIndex() {
        var found = false
        for cell in tableView.visibleCells {
            let vCell = cell as! VideoTableViewCell
            let ccellRect = view.window?.convert(vCell.bounds, from: vCell)
            let p = ccellRect?.origin
            vCell.avPlayer.pause()
			
            if (!found && Float((p?.y)!) > (Float(tableView.frame.size.height)-300.0)/2) {
                NSLog("Visible video at index : %ld",vCell.tag)
                visibleIndex = Int(cell.tag)
                found = true
            }
            
        }
        tableView.reloadData()
    }
    
    func loopVideo(videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem, queue: nil) { notification in
            videoPlayer.seek(to: kCMTimeZero)
            videoPlayer.pause()
        }
    }
}

