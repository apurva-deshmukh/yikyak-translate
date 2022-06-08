import Foundation

class TranslationViewModel: ObservableObject {
    private let translationService = TranslationService()

    @Published var languages: [Language] = []
    @Published var translatedText: String = ""
    @Published var showAlert: Bool = false

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
    
    func translate(_ text: String, from originalLanguage: Language, to language: Language) {
        
        if text.isEmpty {
            self.showAlert = true
            return
        }
        
        translationService.getTranslation(sourceId: originalLanguage.id, targetId: language.id, text: text) { result in
            switch result {
            case .success(let translation):
                self.translatedText = translation.text
                self.showAlert = false
            case .error(_):
                self.showAlert = true
            }
        }
    }
}
