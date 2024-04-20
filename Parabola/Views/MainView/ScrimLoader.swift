import SwiftUI

/**

 ### Exercises for the viewer

 - Phase interrupt handling.
     - Use Swift concurrency.
 - Color scheme awareness.
 - Rework animations to be more spring-like à la what shipped in `0.90.0`.
 - Support a resting state for the vertical split view resize handle.

 */

struct ScrimLoader: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            TimelineView(.animation(paused: viewModel.animationPaused)) { context in
                let elapsed = context.date.timeIntervalSince(viewModel.startDate ?? .now)

                ZStack {
                    Capsule(style: .continuous)
                        .fill(.gray)
                        .opacity(trackOpacity(elapsed: elapsed))

                    let isInSecondPhase = elapsed >= FirstPhase.duration
                    let secondPhaseRemaining = elapsed - FirstPhase.duration
                    let trimStart: CGFloat = {
                        let elapsed = secondPhaseRemaining.truncatingRemainder(dividingBy: SecondPhase.duration)
                        guard ![SecondPhase.first, .third].map(\.range).contains(where: { $0.contains(elapsed) }) else { return 0 }
                        return (elapsed - SecondPhase.second.range.lowerBound) / SecondPhase.second.range.lowerBound
                    }()

                    let trimEnd: CGFloat = {
                        let elapsed = secondPhaseRemaining.truncatingRemainder(dividingBy: SecondPhase.duration)
                        guard !SecondPhase.third.range.contains(elapsed) else { return 0 }
                        guard !SecondPhase.second.range.contains(elapsed) else { return 1 }
                        return elapsed / SecondPhase.first.range.upperBound
                    }()

                    Capsule(style: .continuous)
                        .fill(.black)
                        .clipShape(LeadingToTrailingRectangle(from: trimStart, to: trimEnd))
                        .opacity(isInSecondPhase ? 1 : 0)
                }
            }
            .frame(width: 80, height: 4)

            HStack {
                Button("Start") { viewModel.startLoading() }
                Button("Stop") { viewModel.stopLoading() }
            }
        }
    }

    private enum FirstPhase {
        static let opacityFadeDuration: TimeInterval = 0.5
        static let duration: TimeInterval = 2
    }

    private enum SecondPhase {
        case first, second, third

        var range: ClosedRange<TimeInterval> {
            switch self {
            case .first: return (0...0.25)
            case .second: return (0.25...0.5)
            case .third: return (0.5...0.75)
            }
        }

        static var duration: TimeInterval { Self.third.range.upperBound }
    }

    private func trackOpacity(elapsed: TimeInterval) -> CGFloat {
        guard elapsed < FirstPhase.duration else { return 0.25 }
        let opacity = elapsed.truncatingRemainder(dividingBy: FirstPhase.opacityFadeDuration) / FirstPhase.opacityFadeDuration
        return Int(elapsed / FirstPhase.opacityFadeDuration).isMultiple(of: 2) ? opacity : 1 - opacity
    }

    private final class ViewModel: ObservableObject {
        @Published var startDate: Date?
        var animationPaused: Bool { startDate == nil }
        func startLoading() { startDate = .now }
        func stopLoading() { startDate = nil }
    }
}

private struct LeadingToTrailingRectangle: Shape {
    let from: CGFloat
    let to: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX + rect.width * from, y: rect.minY))
        path.addLine(to: .init(x: rect.minX + rect.width * to, y: rect.minY))
        path.addLine(to: .init(x: rect.minX + rect.width * to, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX + rect.width * from, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
