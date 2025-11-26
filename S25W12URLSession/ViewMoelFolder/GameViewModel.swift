import SwiftUI

@MainActor
@Observable
final class GameViewModel {
    private let repository: GameRepository
    
    init(repository: GameRepository = SupabaseGameRepository()) {
        self.repository = repository
    }
    
    private var _games: [Game] = []
    var games: [Game] { _games }
    
    var path = NavigationPath()
    
    func loadGames() async {
        _games = try! await repository.fetchGames()
    }
    
    func addGame(_ game: Game) async {
        do {
            try await repository.saveGame(game)
            _games.append(game)
        }
        catch {
            debugPrint("에러 발생: \(error)")
        }
    }
    
    func deleteGame(_ game: Game) async {
        do {
            try await repository.deleteGame(game.id.uuidString)
            if let index = _games.firstIndex(where: { $0.id == game.id }) {
                _games.remove(at: index)
            }
        }
        catch {
            debugPrint("에러 발생: \(error)")
        }
    }
}
