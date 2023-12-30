//
//  LocationList.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/3.
//

import SwiftUI

struct LocationList: View {
    @Environment(LocationQuery.self) var fetcher
    @State private var search: String = ""
    @State private var showError = false
    @State private var error: Error?
    @State private var notFound = false
    @State private var noConnection = false
    
    var body: some View {
        VStack{
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
            Text("Location Search")
                .font(.custom("WEEKLY PLANNER", fixedSize: 30))
                .padding(.vertical, -15)
            
            NavigationStack {
                if(noConnection){
                    ContentUnavailableView(
                        "No Internet Connection",
                        systemImage: "wifi.exclamationmark",
                        description: Text("Please check your connection and try again.")
                    )
                }
                else if(notFound){
                    Text("No Data Found")
                }
                else if(fetcher.location.isEmpty && search != ""){
                    ContentUnavailableView(label: {
                        Text ("Fetching Data...")
                            .font(.custom("Hand TypeWriter", fixedSize: 20))
                    }, actions: {
                        Spacer()
                        ProgressView()
                    })
                }
                else{
                    if(search.isEmpty){
                        ContentUnavailableView(label: {
                            Text ("No Content")
                                .font(.custom("Hand TypeWriter", fixedSize: 20))
                        }, actions: {
                        })
                    }
                    else{
                        List {
                            ForEach(fetcher.location) { item in if(item.displayName.contains("Indonesia")){
                                NavigationLink(item.displayName, destination: LocationView(item: item))
                            }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
                }
            }
            .alert(error?.localizedDescription ?? "", isPresented: $showError, actions: {
            })
            .searchable(text: $search)
            .onSubmit(of: .search) {
                Task {
                    do {
                        notFound =  false
                        try await fetcher.queryData(term: search)
                        noConnection = false
                        showError = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                            if(fetcher.location.isEmpty){
                                notFound = true
                            }
                        })
                    } catch {
                        self.error = error
                        showError = true
                        print(error.localizedDescription)
                        if(error.localizedDescription.contains("connect")){
                            noConnection = true
                        }
                        else{
                            noConnection = false
                        }
                    }
                }
            }
            .padding(.top, -20)
        }
    }
}

#Preview {
    LocationList()
        .environment(LocationQuery())
}
