import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        endpoint: GitHubEndpoint,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: endpoint.url) else {
            print("❌ URL oluşturulamadı:", endpoint.url)
            return }
        
        print("🌍 API URL:", url.absoluteString)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ URLSession Hatası:", error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("⚠️ Data yok")
                return
            }
            
            print("📦 Gelen JSON:", String(data: data, encoding: .utf8) ?? "decode edilemedi")
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                print("✅ Decode Başarılı")
                completion(.success(decoded))
            } catch {
                print("❌ Decode Hatası:", error)
                completion(.failure(error))
            }
            
        }.resume()
    }
}


