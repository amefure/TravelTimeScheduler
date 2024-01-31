//
//  EntryTravelViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import UIKit

class EntryTravelViewModel: NSObject {

    private let fbCloudStorageRepository: FBCloudStorageRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        fbCloudStorageRepository = repositoryDependency.fbCloudStorageRepository
    }
    
    public func uploadImgFile(fileName: String, image: UIImage){
        fbCloudStorageRepository.uploadImgFile(fileName: fileName, image: image)
    }
    
    public func downloadImage(completion: @escaping (UIImage) -> Void) {
        fbCloudStorageRepository.downloadImage { image in
            completion(image)
        }
    }
}
