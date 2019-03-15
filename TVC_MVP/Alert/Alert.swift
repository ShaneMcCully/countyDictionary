//
//  Alert.swift
//  TVC_MVP
//
//  Created by Shane McCully on 14/03/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation
import UIKit

struct TitleConstants {

    static let dismiss = "Dismiss"
    static let delete = "Delete"
    static let tryAgain = "Try Again"

}

// NOTE: - AlertableView implementartion from DH

protocol AlertView {
    func presentAlert(title: String?, message: String?, actions: AlertAction...)
}

enum ActionStyle {
    case standard
    case destructive
}

struct AlertAction {
    var title: String?
    var style: ActionStyle?
    var action: (() -> Void)?

    // MARK: - Initialization

    init(title: String, style: ActionStyle = .standard, action: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.action = action
    }

    struct DefaultActions {

        static func dismissAction(_ action: (() -> Void)? = nil) -> AlertAction {
            return AlertAction(title: TitleConstants.dismiss, style: .standard, action: action)
        }

        static func deleteAction(_ action: (() -> Void)? = nil) -> AlertAction {
            return AlertAction(title: TitleConstants.delete, style: .destructive, action: action)
        }

        static func tryAgainAction(_ action: (() -> Void)? = nil) -> AlertAction {
            return AlertAction(title: TitleConstants.tryAgain, style: .standard, action: action)
        }
    }

}

extension ActionStyle {

    var mapStyle: UIAlertAction.Style {
        switch self {
        case .standard: return .default
        case .destructive: return .destructive
        }
    }

}
