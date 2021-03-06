import SwiftUI


struct TranslationView: View {
    
    // moved to View if future functionality included changing the original language
    @State private var originalLanguage: Language = Language(id: "en", name: "English")
    
    @State private var selectedLanguage: Language = Language(id: "en", name: "English")
    @State private var inputText: String = ""
    @StateObject private var viewModel = TranslationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Original")) {
                        TextField("Input text to translate", text: $inputText).padding()
                    }
                    Section(header: Text("Translated")) {
                        Text(viewModel.translatedText).padding()
                    }
                    Section {
                        if viewModel.languages.count > 0 {
                            Picker("Translate to:", selection: $selectedLanguage) {
                                ForEach(viewModel.languages, id: \.self) { language in
                                    Text(language.name)
                                }
                            }
                        }
                        else {
                            Text("Loading languages...").padding()
                        }
                    }
                }.listStyle(InsetGroupedListStyle())
                
                Button("Translate!", action: translate).padding()
            }.errorAlert(showAlert: $viewModel.showAlert)
        }
    }
    
    func translate() {
        viewModel.translate(inputText, from: originalLanguage, to: selectedLanguage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationView()
    }
}
