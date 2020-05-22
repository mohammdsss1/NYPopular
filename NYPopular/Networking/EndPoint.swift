import Foundation

enum EndPoint: APIRouter{
    case mostPopular(period: String)
    
    var method: NetworkLayer.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .mostPopular(let period):
            return "/svc/mostpopular/v2/viewed/\(period).json"
        }
    }
    
    var pathParameters: [String] {
        switch self {
        case .mostPopular(let period):
            return [period]
        }
    }
    
    var queryParemeters: [URLQueryItem]{
        switch self {
        default:
            return [URLQueryItem(name: "api-key", value: NetworkLayer.Consts.apiKey)]
        }
    }
}
