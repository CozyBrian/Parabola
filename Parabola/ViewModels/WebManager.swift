//
//  WebManager.swift
//  Parabola
//
//  Created by Brian Newton on 15/04/2024.
//

import WebKit
import SwiftUI

enum WebLoadingState: String, Equatable, CaseIterable {
    case idle = "idle"
    case loading = "loading"
    case error = "error"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

class WebManager: ObservableObject {
    @Published var webView: WKWebView!
    @Published var webViews: [WKWebView]
    
    @Published var url: String = "https://www.briannewton.dev"
    @Published var isLoading: Bool = false
    @Published var state: WebLoadingState = .idle
    
    init() {
        self.webView = WKWebView()
        self.webViews = []
        loadURL(url)
    }

    func goBack(){
        webView.goBack()
    }
    
    func goForward(){
        webView.goForward()
    }
    
    func loadURL(_ urlString: String) {
        webView.load(URLRequest(url: URL(string: urlString)!))
        webViews.append(webView)
    }
    
    @discardableResult func createNewWebView(urlString: String) -> WKWebView {
        let wv = WKWebView()
        wv.load(URLRequest(url: URL(string: urlString)!))
        webViews.append(wv)
        webView = wv
        
        return wv
    }
}
