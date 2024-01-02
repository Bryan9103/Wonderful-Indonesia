//
//  FirstPageView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import SwiftUI

struct FirstPageView: View {
    @Environment(WikiQuery.self) var wikiQuery
    @Environment(NewsQuery.self) var newsQuery
    var body: some View {
        VStack{
            //upper banner
            HStack(alignment: .center){
                Image(.wonderfulIndonesiaBird)
                    .resizable()
                    .scaledToFit()
                    .frame(width:60)
                    .clipShape(Circle())
                
                VStack(alignment: .center){
                    Text("Wonderful Indonesia")
                        .font(.custom("BlockKie", fixedSize: 30))
                }
            }
            .padding(.top, 10.0)
            
            //content
            NavigationStack{
                ZStack{
                    List{
                        ForEach(wikiQuery.informationData){ item in
                            Section {
                                InfoView(text: item.text, title: item.title, image: item.image, web: "https://en.wikipedia.org/wiki/\(item.title)")
                            } header: {
                                Text(item.title == "Indonesia" ? "About" : "President")
                            }
                            
                        }
                        if(wikiQuery.showWiki){
                            NavigationLink("Indonesian News", destination: NewsList()
                                .environment(newsQuery))
                        }
                    }
                    .task(){
                        if(wikiQuery.showWiki == false){
                            wikiQuery.fetchData()
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                                wikiQuery.showWiki = true
                            })
                        }
                        
                    }
                    if(!wikiQuery.showWiki){
                        ContentUnavailableView(label: {
                            Text ("Fetching Data...")
                                .font(.custom("Hand TypeWriter", fixedSize: 20))
                        }, actions: {
                            Spacer()
                            ProgressView()
                        })
                        .background()
                        
                    }
                }
            }
        }
    }
}

#Preview {
    FirstPageView()
        .environment(WikiQuery())
        .environment(NewsQuery())
}
