//
//  LessonTableViewCell.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class LessonTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeVideoView: YouTubePlayerView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var dislikeCount: UILabel!
    @IBOutlet weak var videoNameLabel: UILabel!
    
    var videoObject : VideoModel?
    var videoCDObject : Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.youtubeVideoView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        
        videoNameLabel.text = videoObject?.videoName
        
        videoCDObject = Video.fetchVideoObjectBasedOnIDForParticularUser(withRequest: Video.fetchRequest() , videoID: (videoObject?.id)!, userID: UserModel.sharedInstance.email)
        
        updateLikeAndDislikeButton()
        updateLikeAndDislikeCount()
        
        activityLoader.startAnimating()
        youtubeVideoView.playerVars = ["playsinline": 0 as AnyObject, "showinfo": 0 as AnyObject, "controls": 0 as AnyObject]
        youtubeVideoView.loadVideoID(videoObject?.videoUrl ?? "")
    }
    
    @IBAction func like(_ sender: Any) {
        updateVideoModelForLikeAndDislike(liked:!(videoCDObject?.isLiked)!, disliked: false)
    }
    
    @IBAction func dislike(_ sender: Any) {
        updateVideoModelForLikeAndDislike(liked:false, disliked: !(videoCDObject?.isDisliked)!)
    }
    
    func updateVideoModelForLikeAndDislike(liked:Bool,disliked:Bool) {
        videoCDObject?.isDisliked = disliked
        videoCDObject?.isLiked = liked
        MusicGenieCoreData.sharedInstance().saveContext()
        updateLikeAndDislikeButton()
        updateLikeAndDislikeCount()
    }
    
    func updateLikeAndDislikeButton() {
        likeButton.setImage(   (videoCDObject?.isLiked)!   ?  UIImage(named: "Like_filled") : UIImage(named: "Like_unfilled") , for: [])
        dislikeButton.setImage(   (videoCDObject?.isDisliked)!   ?  UIImage(named: "Dislike_filled") : UIImage(named: "Dislike_unfilled") , for: [])
    }
    
    
    func updateLikeAndDislikeCount() {
        let videos = Video.fetchVideoObjectBasedOnID(withRequest: Video.fetchRequest(), videoID: (videoObject?.id)!)
        likeCount.text = String(videos?.filter{$0.isLiked ==  true}.count ?? 0)
        dislikeCount.text = String(videos?.filter{$0.isDisliked ==  true}.count ?? 0)
    }
}
extension LessonTableViewCell: YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        activityLoader.stopAnimating()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        print(playbackQuality)
    }
    
}
