protocol GameRepository: Sendable {
    func fetchGames() async throws -> [Game]
    
    func saveGame(_ game: Game) async throws
    
    func deleteGame(_ id: String) async throws
}
