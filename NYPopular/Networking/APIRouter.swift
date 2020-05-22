import Foundation

public protocol APIRouter {
    var scheme: String { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var headers: [NetworkLayer.HeaderItem] { get }
    
    var method: NetworkLayer.HTTPMethod { get }
    
    var queryParemeters: [URLQueryItem] { get }
    /// Any path items that we can then encode to the request string. These will be appended in the order they are found within the array
    var pathParameters: [String] { get }
    
    var bodyParameters: [String: Any] { get }
    
    var requiresAuth: Bool { get }
    
    var cachePolicy: URLRequest.CachePolicy { get }
    
    var timeout: TimeInterval { get }
    
    var encoding: NetworkLayer.Encoding { get }
    
    var charset: NetworkLayer.Charset { get }
    
    var contentType: String { get }
    
    func asURLRequest() -> URLRequest
}

extension APIRouter {
    var scheme: String { "https" }
    
    var host: String { "api.nytimes.com" }
    
    var headers: [NetworkLayer.HeaderItem] { [] }
    
    var queryParemeters: [URLQueryItem] { [] }
    
    var pathParameters: [String] { [] }
    
    var bodyParameters: [String: Any] { [:] }
    
    var requiresAuth: Bool { true }
    
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    
    var timeout: TimeInterval { 20 }
    
    var encoding: NetworkLayer.Encoding { .raw }
    
    var charset: NetworkLayer.Charset { .utf8 }
    
    var contentType: String { getContentType() }
    
    private func getContentType() -> String { "\(encoding.rawValue); \(charset)" }
    
    private func getAccepet() -> String { "\(encoding.rawValue); \(charset)" }
    
    func allHeaders() -> [String: String] {
        var headerList = [
            "Accept": getAccepet()
            ,"Content-Type": getContentType()
        ]
        
        for header in headers {
            headerList[header.field] = header.value
        }
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

extension URLRequest {
    /**
     Returns a cURL command representation of this URL request.
     */
    var cURL: String {
        guard let url = url else { return "" }
        var baseCommand = "curl \(url.absoluteString)"
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
    
    init?(cURL: String) {
        return nil
    }
}
