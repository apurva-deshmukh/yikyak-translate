import Foundation

class TranslationViewModel: ObservableObject {
    private let translationService = TranslationService()
    private let sourceLanguage = Language(id: "en", name: "English")

    @Published var languages: [Language] = []
    
    
    @Published var translatedText: String = ""

    init() {
        translationService.getLanguages() { result in
            switch result {
                case .success(let languages):
                    self.languages = languages
                default:
                    break
            }
        }
    }
}
