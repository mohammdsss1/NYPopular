import Foundation

#warning("move it to a framework")

public enum NetworkLayer {
    public enum Consts{
        static let apiKey = "pwxA18daKtk5IHaIhKjP6MoVEtebPvJy"
    }
    
    public enum HTTPMethod: String {
        case get = "GET"
    }
    
    public struct HeaderItem {
        let field: String
        let value: String
    }
    
    public enum Encoding : String {
        case formURL = "application/x-www-form-urlencoded"
        case raw = "application/json"
        case multipartFormData = "multipart/form-data"
    }
    
    public enum Charset: String {
        case utf8 = "utf-8"
        case utf16 = "utf-16"
        case utf32 = "utf-32"
    }
    
    enum ResponseStatus: String{
        case ok
    }
    
    struct BaseResponse<T: Codable>: Codable {
        var results: T
    }
    
    struct ErrorModel: Error {
        var title: String = "Error"
        var message: String = "Error"
        var statusCode: Int = 999
        var type: ErrorType = .defaultError
        
        init(type: ErrorType) {
            self.type = type
        }
        
        init(title: String = "Sorry", message: String = "", statusCode: Int = 999, type: ErrorType = .defaultError) {
            self.title = title
            self.message = message
            self.statusCode = statusCode
            self.type = type
        }
        
        mutating func setType(statusCode: Int?) {
            switch statusCode {
            case 404:
                type = .notFound
            case 422:
                type = .validationError
            case 500:
                type = .serverError
            default:
                type = .defaultError
            }
        }
    }
    
    enum ErrorType: Error, LocalizedError {
        case parseUrlFail
        case network
        case notFound
        case dataSerialization
        case objectSerialization
        case validationError
        case serverError
        case defaultError
        
        var errorDescription: String? {
            switch self {
            case .parseUrlFail:
                return "Cannot initial URL object."
            case .network:
                return "Check Your Internet."
            case .notFound:
                return "Not Found"
            case .validationError:
                return "Validation Errors"
            case .serverError:
                return "Internal Server Error"
            case .defaultError:
                return "Something Went Wrong."
            case .dataSerialization:
                return "Wrong JSON Fromat "
            case .objectSerialization:
                return "Couldn't serlize This object"
            }
        }
    }
}
