//
//  ContentView.swift
//  AnimeSpringSwiftUI
//
//  Created by Natália Brocca on 01/05/20.
//  Copyright © 2020 Natália Brocca. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var obsAnimes = ObservableAnimes()
    @State var searchBarResults: String = ""
    
    var body: some View {
        NavigationView  {
            VStack {
                SearchBar (text: self.$searchBarResults)
                if self.searchBarResults.isEmpty {
                    self.defaultView
                } else {
                    self.searchView
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Animes")
        }
    }
    
    var defaultView: some View {
        List(obsAnimes.directors) { director in
            VStack(alignment: .leading) {
                Text(director.name)
                .bold()
                .font(.system(size: 25))
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach (self.obsAnimes.animePerDirector[director.name]!) { anime in
                            NavigationLink(destination: DetailsScreen(animeInfo: anime)) {
                                VStack {
                                    anime.photo
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 130, height: 200)
                                        .cornerRadius(10)
                                    Text(anime.name)
                                        .foregroundColor(Color("titleColor"))
                                        .frame(width: 130)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var searchView: some View {
        List(self.filterSearch(listaAnime: self.obsAnimes.listaAnimes, filterAnime: self.searchBarResults)) { anime in
            VStack {
                HStack {
                    NavigationLink(destination: DetailsScreen(animeInfo: anime)) {
                        anime.photo
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 130, height: 200)
                            .cornerRadius(10)
                        VStack (alignment: .leading, spacing: 7) {
                            Text (anime.name)
                                .bold()
                                .font(.system(size: 24))
                            Text (anime.description)
                                .foregroundColor(Color(#colorLiteral(red: 0.387838914, green: 0.4173807876, blue: 0.458716787, alpha: 1)))
                        }
                        .frame(height: 200)
                    }
                }
            }
        }
    }
    
    func filterSearch (listaAnime: [Anime], filterAnime: String) -> [Anime] {
        return listaAnime.filter {
            return $0.name.contains(filterAnime)
        }
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color("backgroundColor")
        .overlay(content)
    }
}

class ObservableAnimes: ObservableObject {
    @Published var listaAnimes: [Anime] = []
    @Published var directors: [Director] = []
    @Published var animePerDirector: [String:[Anime]] = [:]

    init() {
        NetworkServices().getAllMovies { movies, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.listaAnimes = []
                }
            } else if let movies = movies {
                DispatchQueue.main.async {
                    var directorsString: [String] = []
                    movies.forEach {
                        if !directorsString.contains($0.director) {
                            directorsString.append($0.director)
                        }
                        if self.animePerDirector[$0.director] != nil {
                            self.animePerDirector[$0.director]?.append(Anime(name: $0.title, photo: Image($0.id), description: $0.movieDescription))
                        } else {
                            var list: [Anime] = []
                            list.append(Anime(name: $0.title, photo: Image($0.id), description: $0.movieDescription))
                            self.animePerDirector[$0.director] = list
                        }
                        self.listaAnimes.append(Anime(name: $0.title, photo: Image($0.id), description: $0.movieDescription))
                    }
                    self.directors = directorsString.map{ Director(name: $0) }
                }
            }
        }
    }

}

struct Director: Identifiable {
    var id = UUID()
    
    var name: String
}

struct Anime: Identifiable {
    var id = UUID()
    
    //nome, foto, descrição
    var name: String
    var photo: Image
    var description: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
