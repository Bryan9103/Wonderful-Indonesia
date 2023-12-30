//
//  NewsQuery.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import Foundation

@Observable class NewsQuery{
    var news = [NewsFormat]()
    
    enum FetchError: Error{
        case invalidURL
        case badRequest
    }
    
    func queryData() async throws{
        let urlString = "http://api.mediastack.com/v1/news?access_key=4f4c01ceb7bdb10546a6b5292bdcb754&countries=id &languages=en"
        guard let url = URL(string: urlString) else {
            throw FetchError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
        }
        let searchResponse = try JSONDecoder().decode(NewsQueryResult.self, from: data)
        news = searchResponse.data
    }
}
