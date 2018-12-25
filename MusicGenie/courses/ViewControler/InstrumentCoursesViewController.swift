//
//  InstrumentCoursesViewController.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import UIKit

class InstrumentCoursesViewController: BaseViewController {

    @IBOutlet weak var CoursesTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var progresValueLabel: UILabel!
    
    var instrumentModel: Instrument?
    var lessons = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = instrumentModel?.instrumentName
        lessons = (instrumentModel?.basicLessons?.vedios)!
        
        self.reloadTableview()
        self.refreshProgress()
        NotificationCenter.default.addObserver(self, selector: #selector(InstrumentCoursesViewController.refreshProgress), name:NSNotification.Name(rawValue: "VideoViewed"), object: nil)
    }

    func reloadTableview() {
        if !NetworkReachability.sharedManager.isReachable {
            let alertController = UIAlertController(title: "Network Error", message: "Please check your internet connection", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
         CoursesTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        CoursesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:  lessons = (instrumentModel?.basicLessons?.vedios)!
                    break
        case 1: lessons = (instrumentModel?.intermidiateLessons?.vedios)!
                    break
        case 2: lessons = (instrumentModel?.proLessons?.vedios)!
                    break
        default:
            break;
        }
        self.reloadTableview()
    }
}

extension InstrumentCoursesViewController :  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0: return instrumentModel?.basicLessons?.vedios.count ?? 0
//        case 1: return instrumentModel?.intermidiateLessons?.vedios.count ?? 0
//        case 2: return instrumentModel?.proLessons?.vedios.count ?? 0
//        default: return 0
//        }
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lessonCell = tableView.dequeueReusableCell(withIdentifier: "LessonTableViewCell", for: indexPath) as! LessonTableViewCell
//        var vedioObj = VideoModel()
//        switch indexPath.section {
//        case 0: vedioObj =  (instrumentModel?.basicLessons?.vedios[indexPath.row])!
//        case 1: vedioObj =  (instrumentModel?.intermidiateLessons?.vedios[indexPath.row])!
//        case 2: vedioObj =  (instrumentModel?.proLessons?.vedios[indexPath.row])!
//            default: break
//        }
        lessonCell.videoObject = lessons[indexPath.row]//vedioObj
        lessonCell.updateUI()
        lessonCell.selectionStyle = .none
        return lessonCell
    }
    
}
extension InstrumentCoursesViewController :  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.orientation.isLandscape {
            return 450
        }else {
            return 300
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0: return instrumentModel?.basicLessons?.levelName
//        case 1: return instrumentModel?.intermidiateLessons?.levelName
//        case 2: return instrumentModel?.proLessons?.levelName
//        default: return ""
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LessonTableViewCell
        cell.youtubeVideoView.play()
        
        cell.videoCDObject?.isVisited = true
        MusicGenieCoreData.sharedInstance().saveContext()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "VideoViewed"), object: nil, userInfo: nil)
    }
    
    @objc func refreshProgress() {
        let videos = Video.fetchVideoObjectForInstrument(withRequest: Video.fetchRequest(), userID: UserModel.sharedInstance.email, instrument: (instrumentModel?.instrumentName)!)
        let totalVideos = videos?.count
        let visitedVideos = videos?.filter{$0.isVisited ==  true}
        self.progresValueLabel.text = String(((visitedVideos?.count)! * 100)/totalVideos!) + "%"
    }
}
