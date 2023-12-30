//
//  PresidentView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import SwiftUI

struct InfoView: View {
    var text: String
    var title: String
    var image: URL?
    var web: String
    var body: some View {
        HStack{
            AsyncImage(url: image, scale: 2)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 5.0){
                Text(title)
                    .font(.custom("Study Alone", fixedSize: 20))
                
                Divider()
                    .frame(height:1)
                    .background(.primary)
                
                Text(text)
                    .font(.footnote)
                    .font(.system(size: 15))
                    .lineLimit(4)
                    .truncationMode(.tail)
                    .padding(.trailing, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Link("More Info", destination: URL(string: web)!)
                    .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    InfoView(text: "", title: "", image: URL(string: ""), web: "www.google.com")
}
