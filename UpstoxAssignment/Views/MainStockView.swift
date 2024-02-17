//
//  MainStockView.swift
//  UpstoxAssignment
//
//  Created by Arrax on 17/02/24.
//

import SwiftUI

struct MainStockView: View {
    @State private var bottomView: Bool = false
    private let url : String = "https://run.mocky.io/v3/bde7230e-bc91-43bc-901d-c79d008bddc8"
    @State var stockData : [StockData] = []
    @State var currentValue : Double = 0.0
    @State var totalInvestment : Double = 0.0
    @State var todayProfitOrLoss : Double = 0.0
    @State var totalProfitOrLoss : Double = 0.0
    var body: some View {
        NavigationStack{
            VStack{
                List {
                    ForEach(stockData, id: \.id) { data in
                        switch data {
                        case .success(let stocksModel):
                            ForEach(stocksModel.userHolding, id: \.self) { data in
                                VStack {
                                    HStack {
                                        Text(data.symbol)
                                        Spacer()
                                        Text("LTP: ") + Text("₹\(data.ltp, specifier: "%.2f")").bold()
                                    }
                                    HStack {
                                        Text(String(data.quantity))
                                        Spacer()
                                        Text("P/L: ") + Text("₹\(data.pAndl, specifier: "%.2f")").bold()
                                    }
                                }
                            }
                        case .failure(let error):
                            Text("Error: \(error.localizedDescription)")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    stockData.removeAll()
                    toFetchAPI()
                }
                
                TotalStackView()
                    .padding()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Upstox Holding")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(Color(red: 107/255, green: 28/255, blue: 139/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .task {
                toFetchAPI()
            }
        }
    }
    private func TotalStackView() -> some View {
        VStack(spacing: 15){
            Button(action: {
                withAnimation{
                    bottomView.toggle()
                }
            }){
                Image(systemName: bottomView ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .tint(Color(red: 107/255, green: 28/255, blue: 139/255))
            }
            if bottomView {
                BottomView(title: "Current Value:", value: currentValue)
                BottomView(title: "Total Investment:", value: totalInvestment)
                BottomView(title: "Today's Profit & Loss:", value: todayProfitOrLoss)
                    .padding(.bottom, 15)
            }
            BottomView(title: "Profit & Loss:", value: totalProfitOrLoss)
        }
    }
    
    func toFetchAPI() {
        NetworkOperations.shared.fetchDataFromAPI(url: url, model: StocksModel.self) { result in
            switch result {
            case .success(let data):
                // Calculate sum of currentVal
                let currentValSum = sumOfCurrentVal(data.userHolding)
                currentValue += currentValSum
                
                // Calculate sum of investmentVal
                let investValSum = sumOfInvestmentVal(data.userHolding)
                totalInvestment += investValSum
                
                // Calculate totalProfitOrLoss
                totalProfitOrLoss = currentValue - totalInvestment
                
                // Calculate PNL
                let pnlSum = calculatePNL(data.userHolding)
                todayProfitOrLoss += pnlSum
                
                stockData.append(.success(data))
            case .failure(let error):
                stockData.append(.failure(error))
            }
        }
    }
}

#Preview {
    MainStockView()
}
