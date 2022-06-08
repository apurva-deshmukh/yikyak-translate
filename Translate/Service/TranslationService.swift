import Foundation

class TranslationService {
    
    private static let baseAPIURL = URL(string: "https://libretranslate.de/")!
    
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    /**
     Get a list of languages supported by translation API
     */
    func getLanguages(completion: @escaping ((GetLanguagesResult) -> Void)) {
        
        var request = URLRequest(url: TranslationService.baseAPIURL.appendingPathComponent("languages"))
        request.httpMethod = HTTPMethodType.GET()
        
        let task = URLSession(configuration: .default).dataTask(with: request, completionHandler: {
            data, response, sessionError in
            
            if let error = sessionError {
                DispatchQueue.main.async {
                    completion(.error(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.error(TranslationError.noData))
                }
                return
            }
            
            guard let languages = try? JSONDecoder().decode([Language].self, from: data) else {
                DispatchQueue.main.async {
                    completion(.error(TranslationError.jsonParseError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(languages))
            }
        })
        task.resume()
    }
    
    /**
     Get the translation of a text
     
     - Parameter sourceId: language code of original language
     - Parameter targetId: language code of language being translated to
     - Parameter text: the text to translate
     */
    
    func getTranslation(sourceId: String, targetId: String, text: String, completion: @escaping ((GetTranslationResult) -> Void)) {
        
        var request = URLRequest(url: TranslationService.baseAPIURL.appendingPathComponent("translate"))
        request.httpMethod = HTTPMethodType.POST()
        
        let params = [
            FormData.source(): sourceId,
            FormData.target(): targetId,
            FormData.text(): text,
        ]
        let postString = TranslationService.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession(configuration: .default).dataTask(with: request, completionHandler: {
            data, response, sessionError in
            
            if let error = sessionError {
                DispatchQueue.main.async {
                    completion(.error(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.error(TranslationError.noData))
                }
                return
            }
            
            guard let translation = try? JSONDecoder().decode(Translation.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.error(TranslationError.jsonParseError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(translation))
            }
        })
        task.resume()
    }
}
