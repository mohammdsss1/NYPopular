import Foundation

typealias ResultType = Result<[Article], NetworkLayer.ErrorModel>

protocol ArticlesService {
    func getMostPopularArticles(withPeriod period: String, then: @escaping (_ result: ResultType) -> ())
}

final class ArticlesManager{
    lazy var apiHandler = APIHandeler()
}

extension ArticlesManager: ArticlesService{
    func getMostPopularArticles(withPeriod period: String, then: @escaping (ResultType) -> ()) {
        apiHandler.request(endPoint: EndPoint.mostPopular(period: period)) { (result: ResultType) in
            then(result)
        }
    }
}
