//
//  InstrumentDataModel.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import Foundation

class Instrument  {
    var instrumentName  : String = ""
    var basicLessons : VideoLevel?
    var intermidiateLessons : VideoLevel?
    var proLessons : VideoLevel?
}

class VideoLevel  {
    var levelName : String = ""
    var vedios = [VideoModel]()
}

class VideoModel {
    var videoUrl : String = ""
    var videoName : String = ""
    var id : String = ""
}
