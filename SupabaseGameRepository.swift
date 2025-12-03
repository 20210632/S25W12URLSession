import Foundation

final class SupabaseGameRepository: GameRepository {
    func fetchGames() async throws -> [Game] {
        let requestURL = URL(string: GameApiConfig.serverURL)!
        let (data, _) = try! await URLSession.shared.data(from: requestURL)
        let decoder = JSONDecoder()
        return try! decoder.decode([Game].self, from: data)
    }
    
    func saveGame(_ game: Game) async throws {
        let requestURL = URL(string: GameApiConfig.serverURL)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(game)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        //debugPrint(response)
        
        // Guard clause (조건에 맞지 않으면 바로 return (여기서는 throw)) 사용
        guard let httpResponse = response
                as? HTTPURLResponse,
              httpResponse.statusCode == 201
        else {
            throw URLError(.badServerResponse)
        }
    }
    
    func deleteGame(_ id: String) async throws {
        // 주의: eq.value
        let urlString = "\(GameApiConfig.projectURL)/rest/v1/games?id=eq.\(id)&apikey=\(GameApiConfig.apiKey)"
        let requestURL = URL(string: urlString)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        //debugPrint(response)
        
        // Guard cluase (조건에 맞지 않으면 바로 return (여기서는 throw)) 사용
        guard let httpResponse = response
                as? HTTPURLResponse,
              httpResponse.statusCode == 204
        else {
            throw URLError(.badServerResponse)
        }
    }
}
