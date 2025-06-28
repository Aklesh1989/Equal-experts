//
//  SwiftUIView.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//

import SwiftUI

struct MessageStatusView: View {
    let isDelivered: Bool
    let isRead: Bool

    var body: some View {
        Text(statusText)
            .font(.caption2)
            .foregroundColor(.white.opacity(0.8))
    }

    private var statusText: String {
        if isRead {
            return "✔✔"
        } else if isDelivered {
            return "✔"
        } else {
            return "⌛"
        }
    }
}

#Preview {
    MessageStatusView(isDelivered: false, isRead: false)
}
