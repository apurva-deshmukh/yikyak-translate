import Foundation


enum GetLanguagesResult {
    case success([Language])
    case error(Error)
}

enum TranslationError: Error {
    case noData
    case httpError(Int)
    case jsonParseError
}

class TranslationService {

    private static let baseAPIURL = URL(string: "https://libretranslate.de/")!

    /**
      Get a list of languages supported by translation API
      */
    func getLanguages(completion: @escaping ((GetLanguagesResult) -> Void)) {

        var request = URLRequest(url: TranslationService.baseAPIURL.appendingPathComponent("languages"))
        request.httpMethod = "GET"

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
}
