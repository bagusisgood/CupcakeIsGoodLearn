//
//  ContentView.swift
//  CupcakeIsGoodLearn
//
//  Created by Bagus Triyanto on 04/07/20.
//  Copyright © 2020 Bagus Triyanto. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
        
    }
    
    @Published var name = "Bagus Triyanto"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct SongView: View {
    let title: String
    let album: String
    
    var body: some View {
        VStack(alignment:.center) {
            Text(title)
                .font(.system(size: 22))
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            Text(album)
                .font(.headline)
        }
        .padding()
        .frame(width: 350, height: 120)
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(15)
        .foregroundColor(.white)
    }
}

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        NavigationView {
            List(results, id:\.trackId) { item in
                SongView(title: item.trackName, album: item.collectionName)
            }
            .onAppear(perform: loadData)
            .navigationBarTitle(Text("Swifty Good"))
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
