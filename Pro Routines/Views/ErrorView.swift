//
//  ErrorView.swift
//  Pro Routines
//
//  Created by Jorge Felix on 9/21/23.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Error")
                    .font(.title)
                Text(errorWrapper.error.localizedDescription)
                    .padding()
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Text("In other words...")
                    .padding()
                Text(errorWrapper.guidance)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Dismiss")
                    })
                }
            }
        }
    }
}

struct ErrorView_preview: PreviewProvider {
    enum SampleError: Error {
        case whateverError
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.whateverError, guidance: "Something went wrong")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
