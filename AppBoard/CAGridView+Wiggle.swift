import AppKit
import QuartzCore

// MARK: - Wiggle (edit) mode
// Mimics the classic Launchpad "jiggle" behavior: long-press any icon to enter
// edit mode, where all apps and folders gently wiggle and deletable apps show
// a circular close button in the top-left corner.

extension CAGridView {

    // MARK: Public API

    func enterWiggleMode() {
        guard !isWiggleMode else { return }
        guard !items.isEmpty else { return }
        isWiggleMode = true
        startWiggleAnimations()
        refreshDeleteBadgesVisibility()
        NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .now)
    }

    func exitWiggleMode() {
        guard isWiggleMode else { return }
        isWiggleMode = false
        stopWiggleAnimations()
        refreshDeleteBadgesVisibility()
    }

    // MARK: Animations

    func startWiggleAnimations() {
        guard isWiggleMode else { return }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for (pageIdx, pageLayers) in iconLayers.enumerated() {
            for (localIdx, container) in pageLayers.enumerated() {
                applyWiggleAnimation(to: container, seed: pageIdx * 1000 + localIdx)
            }
        }
        CATransaction.commit()
    }

    func stopWiggleAnimations() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for pageLayers in iconLayers {
            for container in pageLayers {
                container.removeAnimation(forKey: "wiggle")
            }
        }
        CATransaction.commit()
    }

    private func applyWiggleAnimation(to layer: CALayer, seed: Int) {
        let amplitude: CGFloat = 0.030  // ~1.7 degrees
        // Slight per-icon variation so the wiggle feels organic.
        let baseDuration: CFTimeInterval = 0.18
        let durationJitter: CFTimeInterval = CFTimeInterval((seed % 7)) * 0.006
        let duration = baseDuration + durationJitter
        let phase = Double((seed &* 13) % 100) / 100.0

        let anim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        anim.values = [0, amplitude, 0, -amplitude, 0]
        anim.keyTimes = [0, 0.25, 0.5, 0.75, 1.0]
        anim.duration = duration
        anim.repeatCount = .infinity
        anim.timeOffset = duration * phase
        anim.isRemovedOnCompletion = false
        anim.calculationMode = .linear
        layer.add(anim, forKey: "wiggle")
    }

    // MARK: Delete badge

    /// Apps that AppBoard should expose a close-button for.
    /// Mirrors the spirit of old Launchpad: system apps are never deletable.
    func isAppDeletable(_ app: AppInfo) -> Bool {
        let path = app.url.path
        if path.hasPrefix("/System/") { return false }
        if path.hasPrefix("/Library/Apple/") { return false }
        guard app.url.pathExtension.lowercased() == "app" else { return false }
        // Require write access to the parent directory so we can actually move it to Trash.
        let parent = app.url.deletingLastPathComponent().path
        return FileManager.default.isWritableFile(atPath: parent)
    }

    func refreshDeleteBadgesVisibility() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for (pageIdx, pageLayers) in iconLayers.enumerated() {
            let pageStart = pageIdx * itemsPerPage
            for (localIdx, container) in pageLayers.enumerated() {
                let globalIdx = pageStart + localIdx
                guard let badge = container.sublayers?.first(where: { $0.name == "deleteBadge" }) else { continue }
                let shouldShow: Bool = {
                    guard isWiggleMode else { return false }
                    guard items.indices.contains(globalIdx) else { return false }
                    guard case .app(let app) = items[globalIdx] else { return false }
                    return isAppDeletable(app)
                }()
                badge.isHidden = !shouldShow
            }
        }
        CATransaction.commit()
    }

    // MARK: Hit testing

    /// Returns the global item index whose delete badge contains the given view-space point, if any.
    func deleteBadgeHit(at point: CGPoint) -> Int? {
        guard isWiggleMode else { return nil }
        guard bounds.width > 0 else { return nil }

        let pageStride = bounds.width + pageSpacing
        let adjustedX = point.x - scrollOffset
        let pageIdx = Int(floor(adjustedX / pageStride))
        guard pageIdx >= 0, pageIdx < iconLayers.count else { return nil }

        let pageStart = pageIdx * itemsPerPage
        let pageLayers = iconLayers[pageIdx]
        for (localIdx, container) in pageLayers.enumerated() {
            guard let badge = container.sublayers?.first(where: { $0.name == "deleteBadge" }),
                  !badge.isHidden else { continue }
            // pageContainerLayer has a translation == scrollOffset; container.frame is in that space.
            let badgeX = container.frame.origin.x + badge.frame.origin.x + scrollOffset
            let badgeY = container.frame.origin.y + badge.frame.origin.y
            let rect = CGRect(x: badgeX, y: badgeY, width: badge.frame.width, height: badge.frame.height)
                .insetBy(dx: -4, dy: -4)  // slightly easier to hit
            if rect.contains(point) {
                return pageStart + localIdx
            }
        }
        return nil
    }

    // MARK: Delete flow

    func performDeleteAction(at globalIndex: Int) {
        guard items.indices.contains(globalIndex), case .app(let app) = items[globalIndex] else { return }
        // Cancel any pending press state.
        longPressTimer?.invalidate()
        longPressTimer = nil
        if let idx = pressedIndex {
            pressedIndex = nil
            applyScaleForIndex(idx, animated: true)
        }
        onDeleteApp?(app)
    }

    // MARK: Badge painting

    static func deleteBadgeCrossPath(in bounds: CGRect) -> CGPath {
        let path = CGMutablePath()
        let inset = bounds.width * 0.30
        let left = bounds.minX + inset
        let right = bounds.maxX - inset
        let top = bounds.maxY - inset
        let bottom = bounds.minY + inset
        path.move(to: CGPoint(x: left, y: bottom))
        path.addLine(to: CGPoint(x: right, y: top))
        path.move(to: CGPoint(x: left, y: top))
        path.addLine(to: CGPoint(x: right, y: bottom))
        return path
    }
}
