//
//  TextFieldManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 09/08/2020.
//

import AudioToolbox

class TextFieldManager: ObservableObject {

    private let characterLimit: Int

    init(characterLimit: Int) {
        self.characterLimit = characterLimit
    }

    @Published var userInput: String = "" {
        didSet {
            if userInput.count > characterLimit {
                userInput = String(userInput.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
}
