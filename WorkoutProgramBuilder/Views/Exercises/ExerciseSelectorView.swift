import SwiftUI
import SwiftData

struct ExerciseSelectorView: View {
    @Binding var selection: Exercise?
    
    @Environment(\.dismiss) private var dismiss
    @Query private var exercises: [Exercise]
    @State private var selectionDraft: Exercise?
    
    var canSubmit: Bool {
        selection != selectionDraft
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if exercises.isEmpty {
                    VStack(spacing: 16) {
                        Text("No exercises...")
                            .font(.title)
                        
                        Text("Go to the exercise tab and create some exercises to add to your workout program.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.secondary)
                    }
                } else {
                    List(selection: $selectionDraft) {
                        ForEach(exercises) { exercise in
                            HStack(spacing: 16) {
                                Image(exercise.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 50)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(exercise.name)
                                    
                                    Text(exercise.category ?? "No category")
                                        .font(.footnote)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                            .tag(exercise as Exercise?)
                        }
                        
                        Text("None")
                            .tag(nil as Exercise?)
                    }
                    .environment(\.editMode, .constant(.active))
                }
            }
            .navigationTitle("Select Exercise")
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
}
