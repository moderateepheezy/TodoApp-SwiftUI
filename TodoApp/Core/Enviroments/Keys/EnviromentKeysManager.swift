//
//  EnviromentKeysManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 06/08/2020.
//

import Foundation
import SwiftUI

struct DataManagerKey: EnvironmentKey {
    static let defaultValue: DataManager = TodoDataManager()
}
