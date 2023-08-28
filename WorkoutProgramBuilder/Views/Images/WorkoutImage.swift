import SwiftUI

enum WorkoutImageSize {
    case small
    case medium
    case large
    
    var value: CGSize {
        let aspectRatio = 0.8
        switch self {
        case .small:
            return .init(width: 34, height: 34 * aspectRatio)
        case .medium:
            return .init(width: 60, height: 60 * aspectRatio)
        case .large:
            return .init(width: 90, height: 90 * aspectRatio)
        }
    }
}

struct WorkoutImage: View {
    let name: String
    let size: WorkoutImageSize
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(size: size.value)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
    }
}


