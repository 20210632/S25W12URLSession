import Foundation

struct Game: Identifiable, Decodable, Hashable {
    let id: UUID
    let title: String
    let genre: String
    let platform: String
    let description: String?
    let image_url: String
}
