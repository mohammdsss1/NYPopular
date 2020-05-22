import Foundation

struct Article: Codable{
    enum Period: String{
        case one = "1"
        case seven = "7"
        case thirty = "30"
    }
    
    var id = 0
    var source = ""
    var title = ""
    var byline = ""
    var publishedDate = ""
    
    enum CodingKeys: String, CodingKey {
        case id, source, title, byline, publishedDate = "published_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.source = try container.decode(String.self, forKey: .source)
        self.title = try container.decode(String.self, forKey: .title)
        self.byline = try container.decode(String.self, forKey: .byline)
        self.publishedDate = try container.decode(String.self, forKey: .publishedDate)
    }
}
