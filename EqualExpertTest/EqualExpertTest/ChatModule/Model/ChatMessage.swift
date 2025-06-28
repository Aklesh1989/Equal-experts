//
//  Untitled.swift
//  EqualExpertTest
//
//  Created by Aklesh Rathaur on 28/06/25.
//
import SwiftUI


struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isSentByUser: Bool
    let timestamp: Date
    var isDelivered: Bool = false
    var isRead: Bool = false
}
