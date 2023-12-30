//
//  SignUpView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmationPassword = ""
//    @EnvironmentObject var userOperation: UserOperation
    @Environment(UserOperation.self) private var userOperation
    
    var body: some View {
        VStack{
            //logo image
            Image(.wonderfulIndonesiaLogo)
                .resizable()
                .scaledToFit()
                .frame(width:300)
                .padding(.vertical, 30)
            
            //form field
            VStack(spacing: 20.0){
                FieldsView(text: $email, title: "Email Address", content: "name@example.com")
                    .textInputAutocapitalization(.none)
                
                FieldsView(text: $username, title: "Full Name", content: "Enter your name")
                
                FieldsView(text: $password, title: "Password", content: "Enter your password", isSecureField: true)
                
                ZStack(alignment: .trailing){
                    FieldsView(text: $confirmationPassword, title: "Confirm Password", content: "Confirm your password", isSecureField: true)
                    
                    if !password.isEmpty && !confirmationPassword.isEmpty {
                        if password == confirmationPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                        }
                        else{
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Button {
                //action
                Task{
                    try await userOperation.createUser(withEmail: email, password: password, username: username)
                }
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(width:UIScreen.main.bounds.width - 30, height:40)
            }
            .background(.blue)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 20)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 5.0){
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size:15))
            }
        }
    }
}

extension SignUpView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && password == confirmationPassword
        && !username.isEmpty
    }
}

#Preview {
    SignUpView()
        .environment(UserOperation())
}
