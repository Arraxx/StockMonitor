//
//  BottomView.swift
//  UpstoxAssignment
//
//  Created by Arrax on 17/02/24.
//

import SwiftUI

struct BottomView: View {
    let title: String
    let value: Double
    
    var body: some View {
        HStack{
            Text(title)
                .bold()
            Spacer()
            Text("₹ \(value, specifier: "%.2f")")
        }
    }
}

//#Preview {
//    BottomView()
//}
