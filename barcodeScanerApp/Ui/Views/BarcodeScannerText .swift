//
//  BarcodeScannerText .swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import SwiftUI

struct BarcodeScannerText: View {
    var text: String
    var color: Color
    var body: some View {
        Text(text)
            .bold()
            .font(.largeTitle)
            .foregroundColor(color)
            .padding()
    }
}
