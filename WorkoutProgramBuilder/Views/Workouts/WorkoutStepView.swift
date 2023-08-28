import SwiftUI
import SwiftData

struct WorkoutStepView: View {
    @Environment(\.editMode) var editMode
    @Bindable var workoutStep: WorkoutStep
    @Query var exercises: [Exercise]
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var addTargetMenu: some View {
        Menu {
            ForEach(WorkoutTargetType.allCases) { targetType in
                Button(
                    action: {
                        switch targetType {
                        case .distance:
                            workoutStep.targets.append(
                                .init(value: 1, type: .distance)
                            )
                            
                        case .duration:
                            workoutStep.targets.append(
                                .init(value: 60, type: .duration)
                            )
                            
                        case .repetition:
                            workoutStep.targets.append(
                                .init(value: 10, type: .repetition)
                            )
                            
                        case .resistance:
                            workoutStep.targets.append(
                                .init(value: 1, type: .resistance)
                            )
                        }
                    },
                    label: {
                        Text(targetType.rawValue)
                    }
                )
            }
        } label: { Image(systemName: "plus") }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Exercise:", selection: $workoutStep.exercise, content: {
                    ForEach(exercises) { exercise in
                        Text(exercise.name)
                            .tag(exercise as Exercise?)
                    }
                    
                    Text("None")
                        .tag(nil as Exercise?)
                })
            } header: { Text("Exercise") }
            
            Section {
                if workoutStep.targets.isEmpty {
                    Text("Add targets to your workout step")
                        .italic()
                        .padding()
                } else {
                    ForEach(workoutStep.targets) { workoutTarget in
                        Stepper(
                            value: $workoutStep.targets.binding(for: workoutTarget).value,
                            in: 1...1000,
                            step: 1
                        ) {
                            Text(parseTargetLabel(for: workoutTarget))
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Targets")
                    
                    Spacer()
                    
                    if isEditing {
                        addTargetMenu
                    }
                }
            }
        }
        .toolbar {
            EditButton()
        }
    }
    
    private func parseTargetLabel(for workoutTarget: WorkoutTarget) -> String {
        "\(workoutTarget.type.rawValue): \(workoutTarget.formattedValue) \(workoutTarget.formattedUnit)"
    }
}

