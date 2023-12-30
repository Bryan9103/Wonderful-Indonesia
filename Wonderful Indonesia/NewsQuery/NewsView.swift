//
//  NewsView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/10.
//

import SwiftUI

struct NewsView: View {
    let news: NewsFormat

    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(news.source)
                .font(.caption)
            NavigationLink(destination: BrowserView(urlString: news.url), label: {
                Text(news.title)
                    .lineLimit(1)
                    .font(.custom("Identidad-ExtraBold", fixedSize: 18))
            })
            Text(news.description)
                .font(.footnote)
                .lineLimit(2)
        }
    }
}

#Preview {
    NewsView(news: NewsFormat(title: "Title of News", description: "This is the description of the news", url: "https://www.google.com", source: "Media Publisher", published_at: "2023-12-01"))
}
