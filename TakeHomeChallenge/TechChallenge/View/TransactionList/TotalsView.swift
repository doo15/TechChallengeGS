//
//  TotalsView.swift
//  TechChallenge
//
//  Created by Dimitris Smyrlakis on 13/05/2022.
//

import SwiftUI

struct TotalsView: View {
    var title = "Category"
    var titleColor = Color.accentColor
    var totalAmount = "$550.45"
    private let sectionTitle = "Total spent"
    
    var body: some View {
        VStack {
            HStack() {
                Spacer()
                Text(title)
                    .headline()
                    .foregroundColor(titleColor)
            }
            .padding(EdgeInsets(top: 20.0, leading: 0.0, bottom: 0.0, trailing: 20.0))
            HStack() {
                Text(sectionTitle)
                    .secondary()
                Spacer()
                Text(totalAmount)
                    .primary()
            }.padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 20.0, trailing: 20.0))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.accentColor, lineWidth: 2)
            )
        .padding(8.0)
    }
}

struct TotalsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalsView()
    }
}
