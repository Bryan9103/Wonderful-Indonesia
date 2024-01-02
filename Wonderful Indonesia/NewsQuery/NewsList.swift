//
//  NewsList.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import SwiftUI
import TipKit

struct InlineTip: Tip {
    var title: Text {
        Text("More info on the news!!")
    }
    var message: Text? {
        Text("Just click on the message and you will be redirected to the news article")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

struct NewsList: View {
    @Environment(NewsQuery.self) var newsQuery
    @State private var showError = false
    @State private var error: Error?
    @State private var notFound = false
    @State private var noConnection = false
    var tip = InlineTip()
    
    var body: some View {
        NavigationStack{
            TipView(tip, arrowEdge: .bottom)
            Button {
                // Invalidate the tip when someone uses the feature.
                tip.invalidate(reason: .actionPerformed)
            } label: {
                Label("Tips", systemImage: "star")
            }
            if(noConnection){
                ContentUnavailableView(
                    "No Internet Connection",
                    systemImage: "wifi.exclamationmark",
                    description: Text("Please check your connection and try again.")
                )
            }
            else if(notFound){
                ContentUnavailableView(label: {
                    Text ("No Data Found")
                        .font(.custom("Hand TypeWriter", fixedSize: 20))
                }, actions: {
                })
            }
            else if(newsQuery.news.isEmpty){
                ContentUnavailableView(label: {
                    Text ("Fetching Data...")
                        .font(.custom("Hand TypeWriter", fixedSize: 20))
                }, actions: {
                    Spacer()
                    ProgressView()
                })
            }
            else{
                List{
                    ForEach(newsQuery.news){ news in
                        NewsView(news: news)
                    }
                }
            }
        }
        .task{
            if newsQuery.news.isEmpty{
                do{
                    try await newsQuery.queryData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
                        if(newsQuery.news.isEmpty){
                            notFound = true
                        }
                    })
                } catch{
                    self.error = error
                    showError = true
                    noConnection = error.localizedDescription.contains("connect") ? true : false;
                }
            }
        }
        .refreshable {
            do{
                try await newsQuery.queryData()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                    if(newsQuery.news.isEmpty){
                        notFound = true
                    }
                })
            } catch{
                self.error = error
                showError = true
                noConnection = error.localizedDescription.contains("connect") ? true : false;
            }
        }
        .alert(error?.localizedDescription ?? "",isPresented:$showError, actions:{})
        
    }
}

#Preview {
    NewsList()
        .environment(NewsQuery())
}
