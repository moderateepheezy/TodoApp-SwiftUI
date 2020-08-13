//
//  PersistenceManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import Foundation

protocol PersistenceManager {
    associatedtype ObjectType
    associatedtype PredicateType

    func create(_ object: ObjectType)
    func fetchFirst(_ objectType: ObjectType.Type, predicate: PredicateType?) -> Result<ObjectType?, Error>
    func fetch(_ objectType: ObjectType.Type, predicate: PredicateType?, limit: Int?) -> Result<[ObjectType], Error>
    func update(_ object: ObjectType)
    func delete(_ object: ObjectType)
}
