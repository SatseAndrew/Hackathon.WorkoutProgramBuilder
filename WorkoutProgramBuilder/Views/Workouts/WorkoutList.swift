import SwiftUI
import SwiftData

struct WorkoutList: View {
    @Environment(\.modelContext) var context
    @Query var items: [Workout]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Design individual workouts to seamlessly integrate into your customized workout programs.")
                    .foregroundStyle(Color.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                List {
                    ForEach(items) { item in
                        NavigationLink(value: item, label: {
                            HStack(spacing: 16) {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 50)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    
                                    Text(item.category ?? "No category")
                                        .font(.footnote)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                        })
                    }
                    .onDelete(perform: delete)
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: add, label: {
                            Label("Add Workout", systemImage: "plus")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
                .navigationTitle("Workouts")
                .navigationDestination(for: Workout.self, destination: {
                    WorkoutView(workout: $0)
                })
            }
        }
    }
    
    private func add() {
        let workout = Workout()
        context.insert(workout)
    }
    
    private func delete(from source: IndexSet) {
        for index in source {
            let item = items[index]
            context.delete(item)
        }
    }
}

#Preview {
    WorkoutList()
}
