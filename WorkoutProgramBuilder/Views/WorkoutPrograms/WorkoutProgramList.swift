import SwiftUI
import SwiftData

struct WorkoutProgramList: View {
    @State private var path = NavigationPath()
    @Environment(\.modelContext) var context
    @Query(sort: \WorkoutProgram.order) var items: [WorkoutProgram]

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Create personalized workout programs here to guide you effortlessly toward achieving your fitness goals!")
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.secondary)
                
                List {
                    ForEach(items) { item in
                        NavigationLink(value: item, label: {
                            HStack(spacing: 16) {
                                WorkoutImage(name: item.imageName, size: .medium)
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    
                                    Text(item.category ?? "No category")
                                        .font(.footnote)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                        })
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    
                    ToolbarItem {
                        Button(action: add, label: {
                            Label("Add Workout Program", systemImage: "plus")
                        })
                    }
                }
                .navigationTitle("Workout Programs")
                .navigationDestination(for: WorkoutProgram.self, destination: {
                    WorkoutProgramView(path: $path, workoutProgram: $0)
                })                
            }
        }
    }
    
    private func add() {
        let workoutProgram = WorkoutProgram(order: items.count)
        context.insert(workoutProgram)
    }
    
    private func delete(from source: IndexSet) {
        for index in source {
            let item = items[index]
            context.delete(item)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        var copy = items
        copy.move(fromOffsets: source, toOffset: destination)
        
        for (index, item) in copy.enumerated() {
            item.order = index
        }
    }
}

#Preview {
    WorkoutProgramList()
        .modelContainer(for: WorkoutProgram.self)
        .preferredColorScheme(.dark)
}
