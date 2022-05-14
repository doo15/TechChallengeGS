import Foundation
import SwiftUI

class FilterModel: Identifiable {
    let title: String
    let color: Color
    var isSelected: Bool
    
    init(title: String, color: Color, isSelected: Bool) {
        self.title = title
        self.color = color
        self.isSelected = isSelected
    }
    
    var id: String {
        return title
    }
}

extension FilterModel {
    static let all = FilterModel(title: "all", color: .black, isSelected: true)
}
