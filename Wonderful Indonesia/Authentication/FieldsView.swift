//
//  SignUpView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import SwiftUI

struct FieldsView: View {
    @Binding var text: String
    let title: String
    let content: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0){
            Text(title)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField{
                SecureField(content, text: $text)
                    .font(.system(size:15))
            }
            else{
                TextField(content, text: $text)
                    .font(.system(size:15))
            }
            
            Divider()
        }
    }
}

#Preview {
    FieldsView(text: .constant(""), title: "Email Address", content: "example@example.com")
}
