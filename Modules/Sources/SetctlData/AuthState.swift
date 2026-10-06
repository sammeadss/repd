//
//  AuthState.swift
//  SetctlModules
//
//  Created by Samuel Meads on 10/5/26.
//

public enum AuthState: Equatable {
    case guest
    case signedIn(userId: String)
}
