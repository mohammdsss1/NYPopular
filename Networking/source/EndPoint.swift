import Foundation

public enum EndPoint: APIRouter{
    case mostPopular(period: String)
    
    public var method: NetworkLayer.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .mostPopular(let period):
            return "/svc/mostpopular/v2/viewed/\(period).json"
        }
    }
    
    public var pathParameters: [String] {
        switch self {
        case .mostPopular(let period):
            return [period]
        }
    }
    
    public var queryParemeters: [URLQueryItem]{
        switch self {
        default:
            return [URLQueryItem(name: "api-key", value: NetworkLayer.Consts.apiKey)]
        }
    }
}
