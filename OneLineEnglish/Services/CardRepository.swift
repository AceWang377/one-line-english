import Foundation

struct CardRepository {
    enum RepositoryError: Error {
        case missingResource
    }

    func loadCards() throws -> [QuoteCard] {
        guard let url = Bundle.main.url(forResource: "quote_cards_v1", withExtension: "json") else {
            throw RepositoryError.missingResource
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([QuoteCard].self, from: data)
    }
}

