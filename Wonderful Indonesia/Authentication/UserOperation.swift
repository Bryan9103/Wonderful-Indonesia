//
//  UserFormat.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol AuthenticationFormProtocol{
    var formIsValid: Bool {get}
}

@Observable class UserOperation{
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    
    init(){
        if(currentUser != nil){
            self.userSession = Auth.auth().currentUser
            Task{
                await fetchUser()
            }
        }
    }
    
    func signin(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch{
            print("FAILED TO LOGIN: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, username: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, username: username, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch{
            //error message alert
            print("FAILED TO CREATE USER: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut() //signs out user
            self.userSession = nil //erases session and return to login screen
            self.currentUser = nil //erases current user data
        } catch{
            print("SIGN OUT FAILED: \(error.localizedDescription)")
        }
    }
    
    func deleteUser(){
        if let user = Auth.auth().currentUser{
            user.delete()
        }
    }
    
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
