//
//  LocalImageStorageRepository.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/02/01.
//

import UIKit

class LocalImageStorageRepository: ImageStorageProtocol {
    
    
    private let fileManager = FileManager.default
    
    // Docmentsフォルダパスを取得
    private func docURL(_ fileName:String) -> URL? {
        do {
            
            let docsUrl = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            let url = docsUrl.appendingPathComponent(fileName)
            return url
        } catch {
            return nil
        }
    }
    
    func uploadImgFile(fileName: String, image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        guard let url = docURL("\(fileName).jpg") else { return }
        do {
            try imageData.write(to: url)
        } catch {
            print("\(error)")
        }
    }
    
    func downloadImage(fileName: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = docURL("\(fileName).jpg") else { return }
        let path = url.path
        guard fileManager.fileExists(atPath: path) else { return }
        
        guard let image = UIImage(contentsOfFile: path) else { return }
        completion(image)
      
    }
    
    func downloadImageUrl(fileName: String, completion: @escaping (URL?) -> Void) {
        guard let url = docURL("\(fileName).jpg") else { return }
        let path = url.path
        guard fileManager.fileExists(atPath: path) else { return }
        completion(url)
    }
    
    func deleteImage(fileName: String) async {
        guard let url = docURL("\(fileName).jpg") else { return }
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print("削除失敗")
        }
    }
    
    
}
