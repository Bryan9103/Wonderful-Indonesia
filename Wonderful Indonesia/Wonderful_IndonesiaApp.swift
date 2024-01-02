//
//  Wonderful_IndonesiaApp.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/3.
//

import SwiftUI
import Firebase
import WikipediaKit
import TipKit

@main
struct Wonderful_IndonesiaApp: App {
    @State private var networkMonitor = NetworkMonitor()
    init(){
        FirebaseApp.configure()
        WikipediaNetworking.appAuthorEmailForAPI = "01057158@mail.ntou.edu.tw"
        try? Tips.resetDatastore()
        try? Tips.configure([
            // The system shows no more than one tip per day.
            .displayFrequency(.daily)
        ])
    }
    
    var body: some Scene {
        WindowGroup{
            MainView()
                .environment(networkMonitor)
//                .environment(userOperation)
        }
    }
}
