//
//  CoinDetailView.swift
//  EquityCoinRanking
//
//  Created by Kag Manoj on 19/2/25.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    let coin: CoinList
        @StateObject private var viewModel: CoinDetailViewModel
    
    init(coin: CoinList) {
            self.coin = coin
            _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        }

    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                }
                .padding()

            }

        }
    }
}


extension CoinDetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(coin.symbol.uppercased())
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
                Text(coin.price.formattedPrice())
                    .font(.headline)
                    .foregroundColor(Color.theme.lightGray)
            }
            Spacer()
            VStack {
                Text("Market Capitalization")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .padding(.bottom, 5)
                Text("$\(coin.marketCapitalization.formattedWithAbbreviations())")
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
                                Angle(degrees:(Double(coin.change) ?? 0) >= 0 ? 0 : 180))
                        
                        Text(Double(coin.change)?.asPercentString() ?? "")
                    }
                    .foregroundColor((Double(coin.change) ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
                    .opacity(Double(coin.change) == nil ? 0.0 : 1.0)
                }
                
                
                Spacer()
                VStack {
                    Text("24H Low")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.bottom, 5)
                    Text("$\(coin.hourlyVol.formattedWithAbbreviations())")
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
                    Text("\(coin.rank)")
                        .font(.headline)
                        .foregroundColor(Color.theme.lightGray)
                }
                Spacer()
            }
        }
    }
}


#Preview {
    
    let sample = CoinList(
        uuid: "Qwsogvtv82FCd",
        name: "Bitcoin",
        price: "97217.3",
        symbol: "BTC",
        iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
        change: "2.09",
        marketCap: "46826432",
        volume24h: "423342",
        rank: 1,
        listedAt: 342132332,
        sparkline: [
            "95232", "95385"
        ])
    CoinDetailView(coin: sample)

}
