//
//  Bundle+Language.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 06/06/2026.
//

import Foundation
import ObjectiveC.runtime

private var bundleKey: UInt8 = 0

private class LocalizedBundle: Bundle {

    override func localizedString(
        forKey key: String,
        value: String?,
        table tableName: String?
    ) -> String {

        guard let bundle = objc_getAssociatedObject(
            self,
            &bundleKey
        ) as? Bundle else {
            return super.localizedString(
                forKey: key,
                value: value,
                table: tableName
            )
        }

        return bundle.localizedString(
            forKey: key,
            value: value,
            table: tableName
        )
    }
}

extension Bundle {

    static func setLanguage(_ language: String) {

        object_setClass(Bundle.main, LocalizedBundle.self)

        guard let path = Bundle.main.path(
            forResource: language,
            ofType: "lproj"
        ),
        let bundle = Bundle(path: path) else {
            return
        }

        objc_setAssociatedObject(
            Bundle.main,
            &bundleKey,
            bundle,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}
