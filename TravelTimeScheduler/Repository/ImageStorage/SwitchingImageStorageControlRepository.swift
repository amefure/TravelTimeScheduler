//
//  SwitchingImageStorageControlRepository.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/02/01.
//

import UIKit

class SwitchingImageStorageControlRepository: ImageStorageProtocol {
    
    static let shared = SwitchingImageStorageControlRepository()
    
    /// サインインしているならFirebaseに切り替える
    private let authVM: AuthViewModel = AuthViewModel.shared
    
    private let fbCloudStorageRepository: FBCloudStorageRepository
    private let localImageStorageRepository: LocalImageStorageRepository
    
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        fbCloudStorageRepository = repositoryDependency.fbCloudStorageRepository
        localImageStorageRepository = repositoryDependency.localImageStorageRepository
    }
    
    
    func uploadImgFile(fileName: String, image: UIImage) {
        if authVM.isSignIn {
            fbCloudStorageRepository.uploadImgFile(fileName: fileName, image: image)
        } else {
            localImageStorageRepository.uploadImgFile(fileName: fileName, image: image)
        }
    }
    
    func downloadImage(fileName: String, completion: @escaping (UIImage?) -> Void) {
        if authVM.isSignIn {
            fbCloudStorageRepository.downloadImage(fileName: fileName) { image in
                completion(image)
            }
        } else {
            localImageStorageRepository.downloadImage(fileName: fileName) { image in
                completion(image)
            }
        }
    }
    
    func downloadImageUrl(fileName: String, completion: @escaping (URL?) -> Void) {
        if authVM.isSignIn {
            fbCloudStorageRepository.downloadImageUrl(fileName: fileName) { url in
                completion(url)
            }
        } else {
            localImageStorageRepository.downloadImageUrl(fileName: fileName) { url in
                completion(url)
            }
        }
    }
    
    func deleteImage(fileName: String) async {
        if authVM.isSignIn {
            await fbCloudStorageRepository.deleteImage(fileName: fileName)
        } else {
            await localImageStorageRepository.deleteImage(fileName: fileName)
        }
    }
    
    

}
