import Foundation

struct APIHandeler {
    private func getSessionManager() -> URLSession {
        if true {
            let configuration = URLSessionConfiguration.default
            Sniffer.enable(in: configuration)
            return URLSession(configuration: configuration)
        } else {
            return URLSession.shared
        }
    }
    
    func request<T: Codable>(endPoint: APIRouter, completion: @escaping (_ result: Result<T, NetworkLayer.ErrorModel>) -> ()) {
        let request = endPoint.asURLRequest()
        
        print("\n\(request.cURL)\n")
        
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

//MARK: - Encodable
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}

//MARK: - Decodable
extension Decodable {
    /// Initialize from JSON Dictionary. Return nil on failure
    init?(dictionary value: [String:Any]){
        
        guard JSONSerialization.isValidJSONObject(value) else { return nil }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else { return nil }
        guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        self = newValue
    }
    
    init?(data value: Data){
        
        guard let newValue = try? JSONDecoder().decode(Self.self, from: value) else {
            return nil
        }
        self = newValue
    }
}
