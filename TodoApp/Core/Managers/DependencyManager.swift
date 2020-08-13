//
//  DependencyManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 10/08/2020.
//

import Foundation

protocol Injectable {}

@propertyWrapper
struct Inject<T: Injectable> {
    let wrappedValue: T
}

class Resolver {
    private var storage = [String: Injectable]()

    static let shared = Resolver()
        private init() {}
}
