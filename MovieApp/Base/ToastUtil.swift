//
//  ToastManager.swift
//  MovieApp
//
//  Created by BeeTech on 09/06/2023.
//

import Foundation
import Toaster

class ToastUtil {
    static func showToast(with msg: String) {
        ToastCenter.default.cancelAll()
        Toast.init(text: msg, duration: 2).show()
    }
}

