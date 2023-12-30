//
//  LocationQuery.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/3.
//

import Foundation

@Observable class LocationQuery{
    var location = [LocationInfo]()
    
    enum FetchError: Error{
        case invalidURL
        case badRequest
    }
    
    func queryData(term: String) async throws{
        let urlString = "https://api.goapi.io/places?search=\(term)&api_key=7d8a57e3-2d85-556e-72c2-3d990051"
        guard let url = URL(string: urlString) else {
            throw FetchError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badRequest
        }
        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
        location = searchResponse.data.results
    }
}
