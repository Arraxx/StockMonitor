//
//  MathematicalCalculation.swift
//  UpstoxAssignment
//
//  Created by Palak on 17/02/24.
//

import Foundation

func sumOfCurrentVal(_ data: [Data]) -> Double {
    return data.reduce(0.0) { $0 + $1.currentVal }
}

func sumOfInvestmentVal(_ data: [Data]) -> Double {
    return data.reduce(0.0) { $0 + $1.investmentVal }
}

func calculatePNL(_ data: [Data]) -> Double {
    return data.reduce(0.0) {
        $0 + Double(Double($1.close) - $1.ltp) * Double($1.quantity)
    }
}
