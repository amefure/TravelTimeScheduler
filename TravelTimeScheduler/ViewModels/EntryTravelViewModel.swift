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
    
    public func downloadImage(fileName: String, completion: @escaping (UIImage?) -> Void) {
        fbCloudStorageRepository.downloadImageUrl(fileName: fileName) { url in
            guard let url = url else { return }
            do {
               let data = try Data(contentsOf: url)
               let image = UIImage(data: data)
                completion(image)
           } catch let error {
               print("Error : \(error.localizedDescription)")
           }
        }
    }
    
    public func deleteImage(fileName: String) {
        Task {
            await fbCloudStorageRepository.deleteImage(fileName: fileName)
        }
    }
    
}
