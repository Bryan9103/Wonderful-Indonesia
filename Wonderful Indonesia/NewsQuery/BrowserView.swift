//
//  BrowserView.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/23.
//

import SwiftUI
import WebKit

struct BrowserView: View {
    @State private var showWebView = false
    var urlString: String
    var body: some View {
        VStack{
            ShareLink(item: urlString)
                .frame(width:350, height: 10, alignment: .trailing)
                
            
            webView(url: URL(string: urlString)!)
            
        }
    }
}

struct webView: UIViewRepresentable{
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url:url)
        uiView.load(request)
    }
}


#Preview {
    BrowserView(urlString:  "https://www.google.com")
}
