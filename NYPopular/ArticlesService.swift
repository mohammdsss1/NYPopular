import Foundation

protocol ArticlesService {
    func getMostPopularArticles(withPeriod period: String, then: @escaping (_ result: Result<[Article], NetworkLayer.ErrorModel>) -> ())
}

final class ArticlesManager{
    lazy var apiHandler = APIHandeler()
}

extension ArticlesManager: ArticlesService{
    func getMostPopularArticles(withPeriod period: String, then: @escaping (Result<[Article], NetworkLayer.ErrorModel>) -> ()) {
        apiHandler.request(endPoint: EndPoint.mostPopular(period: period)) { (result: Result<[Article], NetworkLayer.ErrorModel>) in
            then(result)
        }
    }
}
