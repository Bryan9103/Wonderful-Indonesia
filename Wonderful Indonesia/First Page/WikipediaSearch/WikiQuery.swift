//
//  WikiQuery.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import Foundation
import WikipediaKit

enum FileTransferError: Error {
    case lowBandwidth
    case fileNotFound
}


@Observable class WikiQuery{
    var informationData = [InformationFormat]()
    var showWiki = false
    
    func fetchWikiData(element: String) async throws{
        _ = Wikipedia.shared.requestOptimizedSearchResults(language: WikipediaLanguage("en"), term: element){(searchResults, error) in
            guard error == nil else {return}
            guard let searchResults = searchResults else {return}
            for articlePreview in searchResults.items{
                self.informationData.append(InformationFormat(image: articlePreview.imageURL, title: articlePreview.title, text: articlePreview.displayText))
                break
            }
        }
    }
    
    func fetchData(){
        Task{
            try await fetchWikiData(element: "Joko Widodo")
            try await fetchWikiData(element: "Indonesia")
        }
    }
}
