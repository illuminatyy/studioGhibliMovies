//
//  DetailsScreen.swift
//  AnimeSpringSwiftUI
//
//  Created by Natália Brocca on 01/05/20.
//  Copyright © 2020 Natália Brocca. All rights reserved.
//

import SwiftUI

struct DetailsScreen: View {
    var animeInfo: Anime = Anime(name: "djksahdka", photo: Image("SailorMoonPhoto"), description: "nsadsakdjaskdjaskdjksjdksajcksajklsahdfjsdgfdgbfbsjdhJHDJSAGdhsga")
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    self.animeInfo.photo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height * 0.6)
                        .cornerRadius(20)
                        
                    Text(self.animeInfo.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom)
                    Text(self.animeInfo.description)
                        .padding(.horizontal)
                    Spacer()
                }
            }
        }
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}
