//
//  AuthRepository.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/5/26.
//

import Supabase

public struct AuthRepository: Sendable {
    private let client: SupabaseClient

    public init(client: SupabaseClient) {
        self.client = client
    }

    public func currentUserId() async -> String? {
        try? await client.auth.session.user.id.uuidString
    }
}
