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
        let thumbnailImgRef = reference.child("\(fileName).jpg")
        // 10%に圧縮してData型に変換する
        guard let data = image.jpegData(compressionQuality: 0.1) else { return }
        let uploadTask = thumbnailImgRef.putData(data)
    }
    
    /// 画像Imageダウンロード
    public func downloadImage(fileName: String, completion: @escaping (UIImage?) -> Void) {
        let thumbnailImgRef = reference.child("\(fileName).jpg")
        
        // 最大許容サイズ 1MB (1 * 1024 * 1024 バイト) でメモリにダウンロード
        thumbnailImgRef.getData(maxSize: 1 * 1024 * 1024) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case.failure(let error):
                print(error)
                completion(nil)
                break
            }
        }
    }
    
    /// 画像URLダウンロード
    public func downloadImageUrl(fileName: String, completion: @escaping (URL?) -> Void) {
        let thumbnailImgRef = reference.child("\(fileName).jpg")
        
        thumbnailImgRef.downloadURL { result in
            switch result {
            case .success(let url):
                completion(url)
            case.failure(let error):
                print(error)
                completion(nil)
                break
            }
        }
    }
    
    public func deleteImage(fileName: String) async {
        let thumbnailImgRef = reference.child("\(fileName).jpg")
        do {
          try await thumbnailImgRef.delete()
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
    }
    
}

