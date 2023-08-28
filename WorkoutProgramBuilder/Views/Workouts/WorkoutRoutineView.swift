import SwiftUI

struct WorkoutRoutineView: View {
    @Environment(\.modelContext) var context
    @Bindable var workoutRoutine: WorkoutRoutine
    
    var sortedWorkoutSteps: [WorkoutStep] {
        workoutRoutine.workoutSteps.sorted(by: { $0.order < $1.order })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(workoutRoutine.name)
                
                Spacer()
                
                Button(action: addStep, label: {
                    Image(systemName: "plus")
                })
                .buttonStyle(.borderless)
            }
            
            List {
                ForEach(sortedWorkoutSteps) { step in
                    NavigationLink(value: step, label: {
                        HStack {
                            Text(step.exercise?.name ?? "Undefined")
                            Text("-")
                            Text(parseStepTargets(step.targets))
                        }
                        .font(.footnote)
                        .foregroundStyle(Color.secondary)
                    })
                }
                .onMove(perform: moveSteps)
                .onDelete(perform: deleteSteps)
            }
        }
        .navigationDestination(for: WorkoutStep.self, destination: {
            WorkoutStepView(workoutStep: $0)
        })
    }
    
    private func addStep() {
        let step = WorkoutStep(
            order: workoutRoutine.workoutSteps.count,
            workoutRoutine: workoutRoutine
        )
        
        workoutRoutine.workoutSteps.append(step)
    }
    
    private func deleteSteps(from source: IndexSet) {
        for index in source {
            workoutRoutine.workoutSteps.remove(at: index)
        }
    }

    private func moveSteps(from source: IndexSet, to destination: Int) {
        var copy = sortedWorkoutSteps
        copy.move(fromOffsets: source, toOffset: destination)
        
        for (index, step) in copy.enumerated() {
            step.order = index
        }
    }
    
    private func parseStepTargets(_ workoutTargets: [WorkoutTarget]) -> String {
        var result = [String]()
        
        for target in workoutTargets {
            result.append("\(target.formattedValue) \(target.formattedUnit)")
        }
        
        return result.joined(separator: ", ")
    }
}
