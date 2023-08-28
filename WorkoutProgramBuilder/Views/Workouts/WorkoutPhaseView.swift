import SwiftUI

struct WorkoutPhaseView: View {
    @Bindable var workoutPhase: WorkoutPhase
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var context
    
    var sortedWorkoutRoutines: [WorkoutRoutine] {
        workoutPhase.workoutRoutines.sorted(by: { $0.order < $1.order })
    }
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section {
                Text(workoutPhase.name)
            } header: { Text("Info") }
            
            Section {
                if workoutPhase.workoutRoutines.isEmpty {
                    Text("Add workout routines")
                        .italic()
                        .padding()                    
                } else {
                    ForEach(sortedWorkoutRoutines) { workoutRoutine in
                        WorkoutRoutineView(workoutRoutine: workoutRoutine)
                    }
                    .onDelete(perform: deleteWorkoutRoutines)
                    .onMove(perform: moveWorkoutRoutines)
                }
            } header: {
                HStack {
                    Text("Routines")
                    
                    Spacer()
                    
                    if isEditing {
                        Button(action: addWorkoutRoutine, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
        }
        .toolbar {
            EditButton()
        }
    }
    
    private func addWorkoutRoutine() {
        let order = workoutPhase.workoutRoutines.count

        let workoutRoutine = WorkoutRoutine(
            name: ordinal(from: order + 1),
            order: order,
            workoutPhase: workoutPhase
        )
        
        workoutPhase.workoutRoutines.append(workoutRoutine)
    }
    
    private func deleteWorkoutRoutines(from source: IndexSet) {
        for index in source {
            workoutPhase.workoutRoutines.remove(at: index)
        }
    }
    
    private func moveWorkoutRoutines(from source: IndexSet, to destination: Int) {
        var copy = sortedWorkoutRoutines
        copy.move(fromOffsets: source, toOffset: destination)
        
        for (index, workoutRoutine) in copy.enumerated() {
            workoutRoutine.order = index
            workoutRoutine.name = ordinal(from: index + 1)
        }
    }
    
    private func ordinal(from integer: Int) -> String {
        ordinalFormatter.string(from: NSNumber(integerLiteral: integer)) ?? "unknown"
    }
}
