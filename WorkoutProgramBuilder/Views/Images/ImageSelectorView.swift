import SwiftUI

struct ImageSelectorView: View {
    @Binding var selection: String
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectionDraft: String = "default"
    
    var canSubmit: Bool {
        selection != selectionDraft
    }
    
    var body: some View {
        NavigationStack {
            Grid {
                GridRow {
                    image(withName: "exercise-1")
                    image(withName: "exercise-2")
                    image(withName: "exercise-3")
                }
                
                GridRow {
                    image(withName: "gx-1")
                    image(withName: "gx-2")
                    image(withName: "gx-3")
                }
                
                GridRow {
                    image(withName: "gx-4")
                    image(withName: "gx-5")
                    image(withName: "gx-6")
                }
                
                GridRow {
                    image(withName: "default")
                }
            }
            .navigationTitle("Select an Image")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: submit, label: {
                        Label("Submit Selection", systemImage: "checkmark")
                    })
                    .disabled(!canSubmit)
                }
            }
        }
        .onAppear(perform: { selectionDraft = selection })
    }
    
    private func submit() {
        selection = selectionDraft
        dismiss()
    }
    
    private func image(withName name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 84)
            .opacity(selectionDraft == name ? 1 : 0.7)
            .clipped()
            .onTapGesture { selectionDraft = name }
    }
}

