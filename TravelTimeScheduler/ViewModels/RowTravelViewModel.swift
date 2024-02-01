//
//  RowTravelViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import UIKit

class RowTravelViewModel: NSObject {

    private let imageStorageControlRepository = SwitchingImageStorageControlRepository.shared
    
    public func downloadImageUrl(fileName: String, completion: @escaping (URL?) -> Void) {
        imageStorageControlRepository.downloadImageUrl(fileName: fileName) { url in
            completion(url)
        }
    }
}

