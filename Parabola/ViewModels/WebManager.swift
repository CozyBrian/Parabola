//
//  WebManager.swift
//  Parabola
//
//  Created by Brian Newton on 15/04/2024.
//

import WebKit
import SwiftUI
import Combine

enum WebLoadingState: String, Equatable, CaseIterable {
    case idle = "idle"
    case loading = "loading"
    case error = "error"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

let sites: [String] = [
    "https://www.briannewton.dev",
    "https://www.youtube.com",
    "https://www.google.com"
]

class WebManager: ObservableObject {
    @Published var history: [WKWebView]
    @Published var webView: WKWebView?
    @Published var webViews: [WKWebView]
    @Published var pinnedWebviews: [WKWebView]
    
    @Published var url: String = "https://www.briannewton.dev"
    @Published var isLoading: Bool = false
    @Published var state: WebLoadingState = .idle
    @Published var trigger: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var triggerCancellable: AnyCancellable? = nil
    
    init() {
        self.webViews = []
        self.pinnedWebviews = []
        self.history = []
        sites.forEach { createNewPinnedTab($0) }
        createNewWebView(urlString: url)
        
        triggerCancellable = Timer.publish(
            every: 0.1, on: .main, in: .common
        )
        .autoconnect()
        .sink { _ in
            self.trigger.toggle()
        }
    }

    func goBack(){
        webView?.goBack()
    }
    
    func goForward(){
        webView?.goForward()
    }
    
    func loadURL(_ urlString: String) {
        webView?.load(URLRequest(url: URL(string: urlString)!))
        if (webView != nil) {
            webViews.append(webView!)
        }
    }
    
    @discardableResult func createNewWebView(urlString: String) -> WKWebView {
        let wv = WKWebView()
        wv.load(URLRequest(url: URL(string: urlString)!))
        webViews.append(wv)
        addToHistory()
        webView = wv
        
        return wv
    }
    
    @discardableResult func createNewWebView(newWebView: WKWebView) -> WKWebView {
        webViews.append(newWebView)
        addToHistory()
        webView = newWebView
        
        return newWebView
    }
    
    func isActive(_ item: WKWebView) -> Bool {
        return item == self.webView
    }
    
    func removeFromWebviews(_ webViewItem: WKWebView) {
        webViewItem.pauseAllMediaPlayback()
        webViewItem.setAllMediaPlaybackSuspended(true)
        webViewItem.navigationDelegate = nil
        webViewItem.uiDelegate = nil
        webViews.removeAll(where: { wk in
            wk == webViewItem
        })
        history.removeAll(where: {item in item == webViewItem})
        if webViewItem == webView {
            guard let lastItem = history.last else {
                webView = nil
                return
            }
            webView = lastItem
        }
    }
    
    func setMainWebview(_ webViewItem: WKWebView) {
        addToHistory()
        self.webView = webViewItem
    }
    
    func removeMainWebview() {
        self.webView = nil
    }
    
    func createNewPinnedTab(_ urlString: String) {
        let newtab = WKWebView()
        newtab.load(URLRequest(url: URL(string: urlString)!))
        pinnedWebviews.append(newtab)
    }
    
    private func addToHistory() {
        guard let wv = self.webView else {
            return
        }
        history.removeAll(where: {item in item == wv})
        history.append(wv)
    }
}
