import Foundation

class ArticlesViewModel {
    private let articlesManager: ArticlesService
    var articles = [Article]()
    
    init() {
        articlesManager = ArticlesManager()
    }
    
    func getMostPopularArticles(withPeriod period: String, success: @escaping (([Article]) -> ()), failure: @escaping (NetworkLayer.ErrorModel) -> ()) {
        articlesManager.getMostPopularArticles(withPeriod: period) { [weak self] result in
            guard let self = self else {
                failure(NetworkLayer.ErrorModel.init(type: .defaultError))
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
