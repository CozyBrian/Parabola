//
//  CommandView.swift
//  Parabola
//
//  Created by Brian Newton on 16/04/2024.
//

import SwiftUI

struct CommandView: View {
    @Binding var showCommand: Bool
    @Binding var view: CGSize
    @State   var searchText: String = ""
    
    var body: some View {
        if showCommand {
            VStack(spacing: 0, content: {
                InputBox(searchText: $searchText, showCommand: $showCommand)
                Divider()
                VStack(spacing: 6, content: {
//                    CommandViewItem()
//                    CommandViewItem()
//                    CommandViewItem(isSelected: true)
                })
                .padding(.vertical, 6)
                Spacer()
            })
            .padding(.horizontal, 8.5)
            .frame(maxWidth: 550)
            .frame(height: 299)
            .floatingStyle()
            .position(x: (view.width / 2), y: (view.height / 2))
            
        } else {
            EmptyView()
        }
        Button(action: {
            showCommand.toggle()
        }, label: {
            EmptyView()
        })
        .opacity(0)
        .keyboardShortcut("k", modifiers: .command)
        Button(action: {
            showCommand.toggle()
        }, label: {
            EmptyView()
        })
        .opacity(0)
        .onKeyPress(.escape) {
            self.showCommand = false
            return .handled
        }
    }
    
}

struct InputBox: View {
    enum FocusField: Hashable {
        case field
      }

    @EnvironmentObject var webManager: WebManager
    @FocusState private var focusedField: FocusField?
    @Binding   var searchText: String
    @Binding var showCommand: Bool
    
    var body: some View {
        HStack(spacing: 14, content: {
            Image(systemName: "magnifyingglass")
                .imageScale(.medium)
            TextField("Search or Enter URL...", text: $searchText)
                .textFieldStyle(.plain)
                .font(.system(size: 18))
                .onSubmit {
                    webManager.createNewWebView(urlString: handleUrlOrSearch(searchText))
                    searchText = ""
                    showCommand = false
                }
                .focused($focusedField, equals: .field)
                .onAppear {
                    self.focusedField = .field
                }
        })
        .padding(.horizontal, 12)
        .frame(height: 58)
    }

    func handleUrlOrSearch(_ input: String) -> String {
        // Check if the input is a valid URL
        let isUrl: (String) -> Bool = { input in
            let urlPattern = #"^(https?:\/\/)?([\w\d-]+\.)+[\w\d]{2,}(\/[\w\d-]+)*\/?$"#
            let regex = try? NSRegularExpression(pattern: urlPattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: input.count)
            return regex?.firstMatch(in: input, options: [], range: range) != nil
        }
        
        // Navigate to the URL if it's valid
        if isUrl(input) {
            var formattedURL = input.lowercased()
            if !formattedURL.hasPrefix("https://") {
                formattedURL = "https://\(formattedURL)"
            }
            return formattedURL
        }
        
        // If it's not a URL, treat it as a search query
        return searchWeb(input) ?? ""
    }
    
    func searchWeb(_ query: String) -> String? {
        // Redirect to a search engine or handle search internally
        // For simplicity, let's redirect to Google Search with the query
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let searchUrl = URL(string: "https://www.google.com/search?q=\(encodedQuery)") {
            return searchUrl.absoluteString
        }
        return nil
    }
}


struct CommandViewItem: View {
    var title: String = ""
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 10, content: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(isSelected ? .white.opacity(0.5) : .clear)
                    .frame(width: 24, height: 24)
                Image(systemName: "globe")
                    .imageScale(.medium)
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            Text("Black aBlakc Sheoop")
                .fontWeight(.medium)
            Spacer()
        })
        .padding(.horizontal, 10)
        .frame(height: 46)
        .commandBarItemStyle(isSelected)
    }
}

#Preview {
    CommandView(showCommand: Binding.constant(true), view: Binding.constant(CGSize(width: 600, height: 350)))
}
