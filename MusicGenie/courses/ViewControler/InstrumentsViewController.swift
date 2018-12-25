//
//  InstrumentsViewController.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class InstrumentsViewController: BaseViewController {

    @IBOutlet weak var instrumentsCollectionView: UICollectionView!
    
    var instrumentsArray = [Instrument]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        InitialiseInstrumentData()
        instrumentsCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserData() {
        //fetch
        if let userMail = Auth.auth().currentUser?.email  {
            let currentUser = UserProfile.fetchSavedObject(withRequest: UserProfile.fetchRequest() , user: userMail)
            UserModel.sharedInstance.email = currentUser?.email ?? userMail
            if let image = currentUser?.image {
                UserModel.sharedInstance.image = UIImage(data: image as Data)
            }
            UserModel.sharedInstance.name = currentUser?.name ?? ""
            UserModel.sharedInstance.interest = currentUser?.interests ?? ""
            UserModel.sharedInstance.bio = currentUser?.bio ?? ""
            UserModel.sharedInstance.location = currentUser?.location ?? ""
        }
    }
}

extension InstrumentsViewController :  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instrumentsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let instrumentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstrumentCollectionViewCell", for: indexPath) as! InstrumentCollectionViewCell
        instrumentCell.instrumentImageView?.image = UIImage(named: instrumentsArray[indexPath.item].instrumentName)
        instrumentCell.instrumentNameLabel.text  = instrumentsArray[indexPath.item].instrumentName.uppercased()
        return instrumentCell
    }
    
}
extension InstrumentsViewController :  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InstrumentCoursesViewController") as! InstrumentCoursesViewController
        vc.instrumentModel = instrumentsArray[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: 150)
    }
    

}

extension InstrumentsViewController {
    
    func InitialiseInstrumentData() {

        self.createInstrument(instrumentName: "Guitar", basicVideoLinks: guitarBasicsLinks, IntermidiateVideoLinks: guitarIntermidiateLinks, ProVideoLinks: guitarProLinks)
        self.createInstrument(instrumentName: "Keyboard", basicVideoLinks: keyboardBasicsLinks, IntermidiateVideoLinks: keyboardIntermidiateLinks, ProVideoLinks: keyboardProLinks)
        self.createInstrument(instrumentName: "Flute", basicVideoLinks: fluteBasicsLinks, IntermidiateVideoLinks: fluteIntermidiateLinks, ProVideoLinks: fluteProLinks)
        self.createInstrument(instrumentName: "drums", basicVideoLinks: drumsBasicsLinks, IntermidiateVideoLinks: drumsIntermidiateLinks, ProVideoLinks: drumsProLinks)
        self.createInstrument(instrumentName: "tabla", basicVideoLinks: tablaBasicsLinks, IntermidiateVideoLinks: tablaIntermidiateLinks, ProVideoLinks: tablaProLinks)
        self.createInstrument(instrumentName: "trumpet", basicVideoLinks: trumpetBasicsLinks, IntermidiateVideoLinks: trumpetIntermidiateLinks, ProVideoLinks: trumpetProLinks)
        self.createInstrument(instrumentName: "sitar", basicVideoLinks: sitarBasicsLinks, IntermidiateVideoLinks: sitarIntermidiateLinks, ProVideoLinks: sitarProLinks)
        self.createInstrument(instrumentName: "harmonica", basicVideoLinks: harmonicaBasicsLinks, IntermidiateVideoLinks: harmonicaIntermidiateLinks, ProVideoLinks: harmonicaProLinks)
    }

    func createInstrument(instrumentName:String,basicVideoLinks:[String],IntermidiateVideoLinks:[String],ProVideoLinks:[String]){
        let instrumentObject = Instrument()
        instrumentObject.instrumentName = instrumentName
        
        let basicLevel = VideoLevel()
        basicLevel.levelName = "Basics"  
        basicLevel.vedios = loadVideosToLevel(videos: basicVideoLinks, instrument: instrumentObject.instrumentName, level: basicLevel.levelName)
        
        let intermediateLevel = VideoLevel()
        intermediateLevel.levelName = "Intermediate"
        intermediateLevel.vedios = loadVideosToLevel(videos: IntermidiateVideoLinks, instrument: instrumentObject.instrumentName, level: intermediateLevel.levelName)
        
        let proLevel = VideoLevel()
        proLevel.levelName = "Pro"
        proLevel.vedios = loadVideosToLevel(videos: ProVideoLinks, instrument: instrumentObject.instrumentName, level: proLevel.levelName)
        
        instrumentObject.basicLessons = basicLevel
        instrumentObject.intermidiateLessons = intermediateLevel
        instrumentObject.proLessons = proLevel
        
        instrumentsArray.append(instrumentObject)
    }
    
    func loadVideosToLevel(videos:[String],instrument:String, level:String)->[VideoModel] {
        var videoArray = [VideoModel]()
        
        for (index, item) in videos.enumerated() {
            let video = VideoModel()
            video.videoUrl = item
            video.videoName = "How to play " + instrument + ", " + level + " video " + String(index+1)
            video.id =  instrument + level + String(index+1)
            
            videoArray.append(video)
            
            guard (Video.fetchVideoObjectBasedOnIDForParticularUser(withRequest: Video.fetchRequest() , videoID: video.id, userID: UserModel.sharedInstance.email) != nil) else {
            _ = Video.createVideoModel(managedObjectContext: MusicGenieCoreData.sharedInstance().getContext(),videoID: video.id,userID: UserModel.sharedInstance.email,instrument: instrument)
                continue
            }
        }
        
        return videoArray
    }
    
}
