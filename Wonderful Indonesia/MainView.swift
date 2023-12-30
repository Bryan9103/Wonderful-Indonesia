//
//  MainView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/9.
//

import SwiftUI

struct MainView: View {
    @Environment(NetworkMonitor.self) var networkMonitor
    @State private var userOperation = UserOperation()
    @State private var wikiQuery = WikiQuery()
    @State private var newsQuery = NewsQuery()
    @State private var fetcher = LocationQuery()
    var showAlert = false
    
    var body: some View {
        ZStack{
            VStack{
                Group{
                    if userOperation.userSession != nil{ //use tabs to split pages
                        TabView {
                            FirstPageView()
                                .environment(wikiQuery)
                                .environment(newsQuery)
                                .tabItem { Label("Home", systemImage: "house") }
                            LocationList()
                                .environment(fetcher)
                                .tabItem { Label("Location", systemImage: "map.fill")}
                            UserProfileView()
                                .environment(userOperation)
                                .tabItem {Label("Profile", systemImage: "person")}
                        }
                    }
                    else{
                        LoginPageView()
                            .environment(userOperation)
                    }
                }
            }
            if(!networkMonitor.isConnected){
                ContentUnavailableView(
                    "No Internet Connection",
                    systemImage: "wifi.exclamationmark",
                    description: Text("Please check your connection and try again.")
                )
                .background()
            }
        }
    }
}

#Preview {
    MainView()
        .environment(NetworkMonitor())
}
