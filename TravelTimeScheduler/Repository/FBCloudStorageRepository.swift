//
//  FBCloudStorageRepository.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/31.
//

import UIKit
import FirebaseStorage

class FBCloudStorageRepository {
    
    
    private let reference: StorageReference
    
    init() {
        let storage: Storage = Storage.storage()
        reference = storage.reference().child("Travels")
    }
    
    /// 画像アップロード処理
    public func uploadImgFile(fileName: String, image: UIImage) {
        let sampleImgRef = reference.child("\(fileName).jpg")
        // 10%に圧縮してData型に変換する
        guard let data = image.jpegData(compressionQuality: 0.1) else { return }
        let uploadTask = sampleImgRef.putData(data)
    }
    /// 画像ダウンロード
    public func downloadImage(completion: @escaping (UIImage) -> Void) {
        let sampleImgRef = reference.child("sample.jpg")
        
        sampleImgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            guard let data = data else { return }
            if let error = error {
                print(error)
                return
            }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
    }
}

