//
//  View+Ext.swift
//  Translate
//
//  Created by Apurva Deshmukh on 6/8/22.
//

import SwiftUI

extension View {
    func errorAlert(showAlert: Binding<Bool>, title: String = "Oops! Something went wrong.",
                    message: String = "Please try again later.", buttonTitle: String = "OK")-> some View {
        return alert(title, isPresented: showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(message)
        }
    }
}
