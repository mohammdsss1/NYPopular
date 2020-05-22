import Foundation

public protocol APIRouter {
    var scheme: String { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var method: NetworkLayer.HTTPMethod { get }
    
    var queryParemeters: [URLQueryItem] { get }
    /// Any path items that we can then encode to the request string. These will be appended in the order they are found within the array
    var pathParameters: [String] { get }
    
    var bodyParameters: [String: Any] { get }
        
    var cachePolicy: URLRequest.CachePolicy { get }
    
    var timeout: TimeInterval { get }
    
    var encoding: NetworkLayer.Encoding { get }
    
    var charset: NetworkLayer.Charset { get }
    
    var contentType: String { get }
    
    func asURLRequest() -> URLRequest
}

extension APIRouter {
    public var scheme: String { "https" }
    
    public var host: String { "api.nytimes.com" }
    
    var queryParemeters: [URLQueryItem] { [] }
    
    var pathParameters: [String] { [] }
    
    public var bodyParameters: [String: Any] { [:] }
       
    public var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
      
    public var timeout: TimeInterval { 20 }
    
    public var encoding: NetworkLayer.Encoding { .raw }
    
    public var charset: NetworkLayer.Charset { .utf8 }
    
    public var contentType: String { getContentType() }
    
    private func getContentType() -> String { "\(encoding.rawValue); \(charset)" }
    
    private func getAccepet() -> String { "\(encoding.rawValue); \(charset)" }
    
    func allHeaders() -> [String: String] {
        let headerList = [
            "Accept": getAccepet()
            ,"Content-Type": getContentType()
        ]
        return headerList
    }
    
    public func asURLRequest() -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if !queryParemeters.isEmpty {
            components.queryItems = queryParemeters
        }
        let requestURL = components.url!
        
        var request = URLRequest(url: requestURL, cachePolicy: cachePolicy, timeoutInterval: timeout)
        
        request.httpMethod = method.rawValue
        
        request.allHTTPHeaderFields = allHeaders()
        
        if bodyParameters.count > 0{
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
        }
        
        return request
    }
}
