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
}
