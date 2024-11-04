//
//  ArticleRow.swift
//  NewsReaderApp
//
//  Created by Sachin Datarkar on 30/10/24.
//

import Foundation
import SwiftUI

struct ArticleRowView: View {
    
    @EnvironmentObject var bookmarkViewModel: BookmarkViewModel
    
    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button {
                        toggleBookmark(for: article)
                    } label: {
                        Image(systemName: bookmarkViewModel.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom])
            
        }
    }
    
    private func toggleBookmark(for article: Article) {
        if bookmarkViewModel.isBookmarked(for: article) {
            bookmarkViewModel.removeBookmark(for: article)
        } else {
            bookmarkViewModel.addBookmark(for: article)
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    @StateObject static var bookmarkViewModel = BookmarkViewModel.shared

    static var previews: some View {
        ArticleRowView(article: .previewData[0])
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .environmentObject(bookmarkViewModel)
    }
}
