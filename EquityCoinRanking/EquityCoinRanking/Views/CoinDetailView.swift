//
//  CoinDetailView.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    @State private var readMore: Bool = false
    @StateObject private var viewModel: CoinDetailViewModel
    let uuid: String

    init(uuid: String) {
        self.uuid = uuid
        _viewModel = StateObject(wrappedValue: CoinDetailViewModel())
    }

    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coinDetail)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    coinDescriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                }
                .padding()

            }
            .onAppear {
                viewModel.fetchCoinDetail(uuid: uuid)
            }

        }
    }
}


extension CoinDetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coinDetail.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.text)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var coinDescriptionSection: some View {
        ZStack {
            if let coinDescription = viewModel.coinDetail.description,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription.removingHTMLOccurences)
                        .lineLimit(readMore ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.easeIn) {
                            readMore.toggle()
                        }
                    }, label: {
                        Text(readMore ? "Less" : "Read more")
                            .font(.subheadline.bold())
                            .padding(.vertical, 3)
                    })
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.text)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        HStack {
            VStack {
                Text("Current Price")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.bottom, 5)
                Text(viewModel.coinDetail.price.formattedPrice())
                    .font(.headline)
                    .foregroundColor(Color.theme.lightGray)
            }
            Spacer()
            VStack {
                Text("Market Capitalization")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.bottom, 5)
                Text("$\(viewModel.coinDetail.marketCapitalization.formattedWithAbbreviations())")
                    .font(.headline)
                    .foregroundColor(Color.theme.lightGray)
            }
        }
    }
    
    private var additionalGrid: some View {
        VStack {
            HStack(spacing: 4) {
                VStack() {
                    Text("Current Price")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.bottom, 5)
                    HStack {
                        Image(systemName: "triangle.fill")
                            .rotationEffect(
                                Angle(degrees:(Double(viewModel.coinDetail.change) ?? 0) >= 0 ? 0 : 180))
                        
                        Text(Double(viewModel.coinDetail.change)?.asPercentString() ?? "")
                    }
                    .foregroundColor((Double(viewModel.coinDetail.change) ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                    .opacity(Double(viewModel.coinDetail.change) == nil ? 0.0 : 1.0)
                }
                
                
                Spacer()
                VStack {
                    Text("24H Low")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.bottom, 5)
                    Text("$\(viewModel.coinDetail.hourlyVol.formattedWithAbbreviations())")
                        .font(.headline)
                        .foregroundColor(Color.theme.lightGray)
                }
            }
            .padding(.bottom, 15)
                        
            HStack {
                VStack {
                    Text("Rank")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.bottom, 5)
                    Text("\(viewModel.coinDetail.rank)")
                        .font(.headline)
                        .foregroundColor(Color.theme.lightGray)
                }
                Spacer()
            }
        }
    }
}


#Preview {
    CoinDetailView(uuid: "Qwsogvtv82FCd")

}
