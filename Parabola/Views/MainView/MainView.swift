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
                WebView()
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
    @EnvironmentObject var webManager: WebManager

    func makeNSView(context: Context) -> WKWebView {
        webManager.webView.allowsBackForwardNavigationGestures = true
        webManager.webView.navigationDelegate = context.coordinator
        return webManager.webView
    }
    
    func updateNSView(_ uiView: WKWebView, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(webManager)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
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
    }
}
