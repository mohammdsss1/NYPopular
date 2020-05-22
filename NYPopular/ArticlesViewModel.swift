import Foundation
import Networking

class ArticlesViewModel {
    private let articlesManager: ArticlesService
    var articles = [Article]()
    
    init() {
        articlesManager = ArticlesManager()
    }
    
    func getMostPopularArticles(withPeriod period: Article.Period, success: @escaping (([Article]) -> ()), failure: @escaping (NetworkLayer.ErrorModel) -> ()) {
        articlesManager.getMostPopularArticles(withPeriod: period) { [weak self] result in
            guard let self = self else {
                failure(NetworkLayer.ErrorModel(type: .defaultError))
                return
            }
            
            switch result {
            case .success(let articles):
                self.articles = articles
                success(articles)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
