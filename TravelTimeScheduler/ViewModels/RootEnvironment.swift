//
//  RootEnvironment.swift
//  TravelTimeScheduler
//
//  Created by t&a on 2024/01/23.
//

import UIKit

class RootEnvironment: ObservableObject {
    
    static let shared = RootEnvironment()
    
    @Published private(set) var isDeleteMode = false
    private let userDefaultsRepository: UserDefaultsRepository
    
    private init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    public func onDeleteMode() {
        isDeleteMode = true
    }
    
    public func offDeleteMode() {
        isDeleteMode  = false
    }
}
