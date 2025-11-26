protocol GameRepository: Sendable {
    func fetchGames() async throws -> [Game]
}
