//
//  ProfileComponent.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import SwiftUI

struct ProfileComponent: View {
    var imageName: String
    var title: String
    var symbolColor: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 10.0){
            Image(systemName:imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(symbolColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.foreground)
        }
    }
}

#Preview {
    ProfileComponent(imageName: "gear", title: "Version", symbolColor: .gray)
}
