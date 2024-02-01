//
//  ImageStorageRepository.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/02/01.
//

import UIKit

protocol ImageStorageProtocol {

    /// 画像アップロード処理
    func uploadImgFile(fileName: String, image: UIImage)
    
    /// 画像Imageダウンロード
    func downloadImage(fileName: String, completion: @escaping (UIImage?) -> Void)
    
    /// 画像URLダウンロード
    func downloadImageUrl(fileName: String, completion: @escaping (URL?) -> Void)
    
    /// 画像削除
    func deleteImage(fileName: String) async
    
}
