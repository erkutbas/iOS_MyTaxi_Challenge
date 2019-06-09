//
//  PoiiListData.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

// MARK: - PoiListData
class PoiListData: Codable {
    let poiList: [PoiList]?
    
    init(poiList: [PoiList]?) {
        self.poiList = poiList
    }
}

// MARK: - PoiList
class PoiList: Codable {
    let id: Int?
    let coordinate: Coordinate?
    let state: State?
    let type: TypeEnum?
    let heading: Double?
    
    init(id: Int?, coordinate: Coordinate?, state: State?, type: TypeEnum?, heading: Double?) {
        self.id = id
        self.coordinate = coordinate
        self.state = state
        self.type = type
        self.heading = heading
    }
}

// MARK: - Coordinate
class Coordinate: Codable {
    let latitude, longitude: Double?
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

enum State: String, Codable {
    case active = "ACTIVE"
}

enum TypeEnum: String, Codable {
    case taxi = "TAXI"
}
