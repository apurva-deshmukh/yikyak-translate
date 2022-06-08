//
//  APIEnums.swift
//  Translate
//
//  Created by Apurva Deshmukh on 6/8/22.
//

enum GetLanguagesResult {
    case success([Language])
    case error(Error)
}

enum GetTranslationResult {
    case success(Translation)
    case error(Error)
}

enum TranslationError: Error {
    case noData
    case httpError(Int)
    case jsonParseError
}

enum HTTPMethodType: String {
    case GET = "GET"
    case POST = "POST"
    
    func callAsFunction() -> String {
        return self.rawValue
    }
}

enum FormData: String {
    case source = "source"
    case target = "target"
    case text = "q"
    
    func callAsFunction() -> String {
        return self.rawValue
    }
}
