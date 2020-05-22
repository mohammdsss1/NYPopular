import Foundation

let DEBUG_API = true

/// Manages API calls to server
public struct APIHandeler {
    public init() {}
    
    private func getSessionManager() -> URLSession {
        if DEBUG_API {
            let configuration = URLSessionConfiguration.default
            Sniffer.enable(in: configuration)
            return URLSession(configuration: configuration)
        } else {
            return URLSession.shared
        }
    }
    
    /**
     Sends a request to the specified endpoint
     - Parameter endPoint: an enum to the target endpoint
     - Parameter completion: completion closure usinf Swift's Result type
     */
    public func request<T: Codable>(endPoint: APIRouter, completion: @escaping (_ result: Result<T, NetworkLayer.ErrorModel>) -> ()) {
        let request = endPoint.asURLRequest()
        let session: URLSession = getSessionManager()
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            guard let statusCode = urlResponse?.getStatusCode(), 200 == statusCode/*NetworkLayer.ResponseStatus.ok.contains(statusCode)*/ else {
                var errorModel = NetworkLayer.ErrorModel()
                let statusCode = urlResponse?.getStatusCode()
                errorModel.setType(statusCode: statusCode)
                completion(.failure(errorModel))
                return
            }
            
            guard let data = data else {
                let errorModel = NetworkLayer.ErrorModel(type: NetworkLayer.ErrorType.dataSerialization)
                completion(.failure(errorModel))
                return
            }
            
            do {
                if let str = String(data: data, encoding: .utf8) {
                    print("str:\(str)")
                }
                
                let response = try JSONDecoder().decode(NetworkLayer.BaseResponse<T>.self, from: data)
                completion(Result.success(response.results))
            } catch _ {
                let errorModel = NetworkLayer.ErrorModel(type: NetworkLayer.ErrorType.objectSerialization)
                completion(.failure(errorModel))
            }
        }
        task.resume()
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
