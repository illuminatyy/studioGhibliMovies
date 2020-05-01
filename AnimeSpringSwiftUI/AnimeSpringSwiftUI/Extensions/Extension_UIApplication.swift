//
//  Extension_UIApplication.swift
//  AnimeSpringSwiftUI
//
//  Created by Natália Brocca on 01/05/20.
//  Copyright © 2020 Natália Brocca. All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
