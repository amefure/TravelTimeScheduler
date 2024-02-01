//
//  EntryTravelViewModel.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import UIKit

class EntryTravelViewModel: NSObject {

    private let validationUtility = ValidationUtility()
    private let fbCloudStorageRepository: FBCloudStorageRepository
   
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        fbCloudStorageRepository = repositoryDependency.fbCloudStorageRepository
    }
}

// MARK: - Firebase Cloud Storage
extension EntryTravelViewModel {
    public func uploadImgFile(fileName: String, image: UIImage){
        fbCloudStorageRepository.uploadImgFile(fileName: fileName, image: image)
    }
    
    public func downloadImage(fileName: String, completion: @escaping (UIImage?) -> Void) {
        fbCloudStorageRepository.downloadImage(fileName: fileName) { image in
            completion(image)
        }
    }
    
    public func deleteImage(fileName: String) {
        Task {
            await fbCloudStorageRepository.deleteImage(fileName: fileName)
        }
    }
}

// MARK: - Private Method
extension EntryTravelViewModel {
    public func validatuonInput(str: String) -> Bool{
        validationUtility.validateEmpty(str: str)
    }
}



