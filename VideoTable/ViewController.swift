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
    //var visibleIndex:Int = 0
    var videoHeight:Float = 0.0
    
    var cache: NSMutableDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "VideoCellView", bundle: nil), forCellReuseIdentifier: "VideoCell")
        let gapTableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.tableHeaderView = gapTableViewHeader
            
        // init constants

        // init variables
        cache = [:]

        
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
            Notificator.fireNotification(named: kUpdateVideoCell)
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
        
        newCell.listenForPlayerChanges()
        newCell.indexPath = indexPath
        
        
        // get url
        if let url = URL(string: urls[indexPath.row] as! String){
            let avLayer = cache.object(forKey: String(indexPath.row))
            let newLayer: AVPlayerLayer
            if avLayer == nil {
                let videoPlayer = AVPlayer(url: url)
                let avLayer = AVPlayerLayer(player: videoPlayer)
                
                cache.setObject(avLayer, forKey: String(indexPath.row) as NSCopying)
                newLayer = avLayer
            } else{
                newLayer = avLayer as! AVPlayerLayer
            }

            newCell.PlayerView.layer.sublayers = nil;
            newLayer.frame = newCell.PlayerView.bounds
            newCell.PlayerView.layer.addSublayer(newLayer)
            newCell.avLayer = newLayer
            newCell.avPlayer = newCell.avLayer.player!
            newCell.avPlayer.pause()
            newCell.makePlayerLoop()
            
            newCell.avPlayer.isMuted = false
            newCell.selectionStyle = UITableViewCellSelectionStyle.none
        }
               
        
        
        return newCell;
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        Notificator.fireNotification(named: kUpdateVideoCell)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         resetVisibleIndex()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        resetVisibleIndex()
    }
    
    func updateCurrentIndex() -> IndexPath? {
        //when scroll end get the current display off set
        let visibleStartPoint = self.tableView.contentOffset
        //calculate the center point in view
        let selectionPoint = CGPoint(x:self.tableView.frame.width/2,y: visibleStartPoint.y + self.tableView.frame.height/2)
        //get the index path in center position
        let pt = CGPoint(x:selectionPoint.x,y: selectionPoint.y)
        if let indexPath = self.tableView.indexPathForRow(at:pt){
            return indexPath
        }
        return nil
    }
    
    func resetVisibleIndex(){
        if let idx = updateCurrentIndex(){
            currentlyPlayingIndex = idx
            Notificator.fireNotification(named: kUpdateVideoCell)
        }
    }

    
 
}

