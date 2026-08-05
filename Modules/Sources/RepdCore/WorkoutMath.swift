//
//  WorkoutMath.swift
//  RepdModules
//
//  Created by Samuel Meads on 8/5/26.
//

public enum WorkoutMath {
    public static func totalVolume(of sets: [(reps: Int, weight: Double)]) -> Double {
        sets.reduce(0) { total, set in
            total + Double(set.reps) * set.weight
        }
    }
}
