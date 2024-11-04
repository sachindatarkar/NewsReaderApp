//
//  NewsArticleList.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 02/11/24.
//

import SwiftUI

struct NewsArticleList: View {
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) { article in
            if let url = URL(string: article.url) {
                WebView(url: url)
            }
        }
    }
}

struct NewsArticleList_Previews: PreviewProvider {
    
    @StateObject static var bookmarkViewModel = BookmarkViewModel.shared
    static var previews: some View {
        NewsArticleList(articles: Article.previewData)
            .environmentObject(bookmarkViewModel)
    }
}
