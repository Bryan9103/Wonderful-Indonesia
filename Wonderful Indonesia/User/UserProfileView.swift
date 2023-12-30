//
//  UserProfileView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(UserOperation.self) private var userOperation
    
    var body: some View {
        if let user = userOperation.currentUser{
            List{
                Section{
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width:70, height:70)
                            .background(.gray)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5.0){
                            Text(user.username)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 5)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                        .padding(.leading, 5.0)
                    }
                }
                
                Section("General"){
                    HStack{
                        ProfileComponent(imageName: "gear", title: "Version", symbolColor: .gray)
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Account"){
                    Button{
                        //action
                        userOperation.signOut()
                    } label:{
                        ProfileComponent(imageName: "arrow.left.circle.fill", title: "Log Out", symbolColor: .red)
                    }
                    
                    Button{
                        //action
                        userOperation.deleteUser()
                        userOperation.signOut()
                    } label:{
                        ProfileComponent(imageName: "xmark.circle.fill", title: "Delete Account", symbolColor: .red)
                    }
                }
            }
        }
    }
}

#Preview {
    UserProfileView()
        .environment(UserOperation())
}
