//
//  LoginPage.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import SwiftUI

struct LoginPageView: View {
    @State private var email = ""
    @State private var password = ""
//    @EnvironmentObject var userOperation: UserOperation
    @Environment(UserOperation.self) private var userOperation
    
    
    var body: some View {
        NavigationStack{
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
//                        .textCase(.lowercase)
////                        .textInputAutocapitalization(.never)
                    
                    FieldsView(text: $password, title: "Password", content: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                //sign - in
                Button {
                    //action
                    Task{
                        try await userOperation.signin(withEmail: email, password: password)
                    }
                    
                } label: {
                    HStack{
                        Text("SIGN IN")
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
                
                //sign - up
                NavigationLink {
                    // destination
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 5.0){
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size:15))
                }

            }
        }
    }
}

extension LoginPageView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginPageView()
        .environment(UserOperation())
}
