import Foundation

final class SupabaseGameRepository: GameRepository {
    func fetchGames() async throws -> [Game] {
        let requestURL = URL(string: SongApiConfig.serverURL)!
        let (data, _) = try! await URLSession.shared.data(from: requestURL)
        let decoder = JSONDecoder()
        return try! decoder.decode([Game].self, from: data)
    }
}
