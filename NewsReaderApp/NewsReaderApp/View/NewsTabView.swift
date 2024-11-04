//
//  NewsTabView.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var viewModel = ArticleNewsViewModel()
    @State private var selectedArticle: Article?
    
    var body: some View {
        NavigationView {
            NewsArticleList(articles: viewModel.articles)
            .listStyle(.plain)
            .onAppear {
                viewModel.loadNews()
            }
            .navigationTitle(viewModel.selectedCategory.rawValue.capitalized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(NewsCategory.allCases) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                                viewModel.loadNews(for: category)
                            }) {
                                HStack {
                                    Text(category.displayName)
                                    if viewModel.selectedCategory == category {
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    } label: {
                        Label("Categories", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    @StateObject static var bookmarkViewModel = BookmarkViewModel.shared
    
    static var previews: some View {
        NewsTabView(viewModel: ArticleNewsViewModel())
            .environmentObject(bookmarkViewModel)
    }
}
