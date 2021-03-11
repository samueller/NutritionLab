import SwiftUI

struct SearchView: View {
    struct Result: Decodable {
        struct Data: Identifiable, Decodable {
            let id: String
            let text: String
        }
        
        struct Meta: Decodable {
            let newest_id: String
            let oldest_id: String
            let next_token: String?
            let result_count: Int
        }
        
        let data: [Data]
        let meta: Meta
    }
    
    let query: String
    
    @State var result: Result?
    
    func search() {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.twitter.com"
        components.path = "/2/tweets/search/recent"
        components.queryItems = [.init(name: "query", value: query)]
        
        var request = URLRequest(url: components.url!)
        
        request.setValue(
            "Bearer \(TWITTER_TOKEN)",
            forHTTPHeaderField: "Authorization"
        )
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                guard let result = try? JSONDecoder().decode(Result.self, from: data) else {
                    print("Invalid data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.result = result
                }
            } else {
                print(error ?? "An unknown error has occurred")
            }
        }.resume()
    }
    
    var body: some View {
        Group {
            if let result = result {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(result.data) { tweet in
                            Text(tweet.text)
                        }
                    }
                    .padding()
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear(perform: search)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(query: "Whole fruit")
    }
}
