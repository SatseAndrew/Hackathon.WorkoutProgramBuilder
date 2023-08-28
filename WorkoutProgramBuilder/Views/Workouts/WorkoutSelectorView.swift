import SwiftUI
import SwiftData

struct WorkoutSelectorView: View {
    @Binding var selection: [Workout]
    
    @Environment(\.dismiss) private var dismiss
    @Query private var workouts: [Workout]
    @State private var selectionDraft = Set<Workout>()
    
    var canSubmit: Bool {
        Set(selection) != selectionDraft
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if workouts.isEmpty {
                    VStack(spacing: 16) {
                        Text("No workouts...")
                            .font(.title)
                        
                        Text("Go to the workout tab and create some workouts to add to your workout program.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.secondary)
                    }
                } else {                    
                    List(workouts, selection: $selectionDraft) { workout in
                        Text(workout.name)
                            .tag(workout)
                    }
                    .environment(\.editMode, .constant(.active))
                }
            }
            .navigationTitle("Select Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: submit, label: {
                        Label("Submit Selection", systemImage: "checkmark")
                    })
                    .disabled(!canSubmit)
                }
            }
        }
        .onAppear(perform: { selectionDraft = Set(selection) })
    }
    
    private func submit() {
        selection = Array(selectionDraft)
        dismiss()
    }
}

#Preview {
    WorkoutSelectorView(selection: .constant([]))
}
