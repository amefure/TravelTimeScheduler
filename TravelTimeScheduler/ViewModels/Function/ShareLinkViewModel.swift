//
//  ShareLinkViewModel.swift
//  FuluLog
//
//  Created by t&a on 2023/03/28.
//

import UIKit

class ShareLinkViewModel {
    private let model = ShareLinkModel()

    public func shareApp(shareText: String, shareLink: String) {
        model.shareApp(shareText: shareText, shareLink: shareLink)
    }
}
