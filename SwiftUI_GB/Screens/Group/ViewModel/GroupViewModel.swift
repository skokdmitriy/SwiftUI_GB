//
//  GroupViewModel.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 21.08.2022.
//

import Foundation
import SwiftUI

class GroupViewModel: ObservableObject {
    let apiGroup: GroupService
    
    @Published var groups: [GroupModel] = []
    
    init(apiGroup: GroupService) {
        self.apiGroup = apiGroup
    }
    
    public func fetchGroups() {
        apiGroup.loadGroups() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                self.groups = groups.response.items
            case let .failure(error):
                print(error)
            }
        }
    }
}
