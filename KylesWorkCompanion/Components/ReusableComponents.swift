import SwiftUI

struct StatusBadge: View { let text: String; let systemImage: String; var body: some View { Label(text, systemImage: systemImage).font(.caption).padding(6).background(.thinMaterial, in: Capsule()).accessibilityLabel(text) } }
struct EmptyStateView: View { let title: String; let message: String; var body: some View { ContentUnavailableView(title, systemImage: "tray", description: Text(message)) } }
struct ClinicalSection<Content: View>: View { let title: String; @ViewBuilder var content: Content; var body: some View { Section { content } header: { Text(title).font(.headline) } } }
struct CopyButton: View { let text: String; var body: some View { Button { UIPasteboard.general.string = text } label: { Label("Copy", systemImage: "doc.on.doc") } } }
