//
//  MainView.swift
//  Parabola
//
//  Created by Brian Newton on 13/04/2024.
//

import SwiftUI
import WebKit

struct MainView: View {
    @EnvironmentObject var webManager: WebManager
    
    var body: some View {
        VStack(spacing: 0, content: {
            LoadingBar()
            VStack {
                WebView(webManager: webManager)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.18))
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(color: Color.black.opacity(0.5), radius: 2.5, x: 0, y: 0)
            .opacity(1)
            
        })
        .padding([.bottom,.trailing], 10)
    }
}

#Preview {
    ContentView(parentWindow: MainWindow()).environmentObject(WebManager()).frame(width: 800)
}

struct WebView: NSViewRepresentable {
    @ObservedObject var webManager: WebManager

    func makeNSView(context: Context) -> WKWebView {
        let wk = WKWebView()
        wk.allowsBackForwardNavigationGestures = true
        wk.navigationDelegate = context.coordinator
        wk.uiDelegate = context.coordinator
        return wk
    }
    
    func updateNSView(_ uiView: WKWebView, context: Context) {
        guard let webView = webManager.webView else {
            return
        }

        if webView != uiView.subviews.first {
            uiView.subviews.forEach { $0.removeFromSuperview() }
            
            webView.frame = CGRect(origin: .zero, size: uiView.bounds.size)
            uiView.addSubview(webView)
            uiView.allowsBackForwardNavigationGestures = true
            uiView.navigationDelegate = context.coordinator
            uiView.uiDelegate = context.coordinator
            webView.allowsBackForwardNavigationGestures = true
            webView.navigationDelegate = context.coordinator
            webView.uiDelegate = context.coordinator
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(webManager)
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        private let parent: WebManager

        init(_ parent: WebManager) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("Webview started loading.")
            parent.state = .loading
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Webview finished loading.")
            parent.state = .idle
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.state = .error
            print("Webview failed with error: \(error.localizedDescription)")
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            if webView == parent.webView {
                parent.url = webView.url?.absoluteString ?? "https://www.briannewton.dev"
            }
        }
        
//        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//            print("tried oo")
//            if navigationAction.targetFrame == nil {
//                let popupWebView = WKWebView(frame: .zero, configuration: configuration)
//                popupWebView.navigationDelegate = self
//                popupWebView.uiDelegate = self
//                
//                parent.webView.addSubview(popupWebView)
//                popupWebView.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
//                    popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
//                    popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
//                    popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
//                ])
//                
//                self.parent.webViews.append(popupWebView)
//                return popupWebView
//            }
//            
//            return nil
//        }
    }
}
