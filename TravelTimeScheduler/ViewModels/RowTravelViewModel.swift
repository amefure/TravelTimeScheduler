//
//  RowTravelViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import UIKit

class RowTravelViewModel: NSObject {

    private let fbCloudStorageRepository: FBCloudStorageRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        fbCloudStorageRepository = repositoryDependency.fbCloudStorageRepository
    }
    
    public func downloadImageUrl(fileName: String, completion: @escaping (URL?) -> Void) {
        fbCloudStorageRepository.downloadImageUrl(fileName: fileName) { url in
            completion(url)
        }
    }
}

