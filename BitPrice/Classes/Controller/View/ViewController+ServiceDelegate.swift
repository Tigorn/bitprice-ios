//
//  ViewController+TickerServiceDelegate.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 27/01/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import Charts
import UIKit

extension ViewController: TickerApiServiceDelegate {
    
    func tickerApiGetDidComplete(ticker: Ticker) {
        bodyView.priceView.setPrice(ticker.USD.last)
        spinnerView.hide()
    }
    
    func tickerApiGetDidComplete(error: Error?) {
        spinnerView.hide()
    }
    
}

extension ViewController: MarketPriceApiServiceDelegate {
    
    func marketPriceApiGetDidComplete(marketPrice: MarketPrice) {
        let ref = UserDefaults.standard.reference()
        let firsPrice = marketPrice.values.first?.y ?? 0
        let lastPrice = marketPrice.values.last?.y ?? 0
        var values = [ChartDataEntry]()
        
        for value in marketPrice.values {
            let x = Double(value.x)
            let y = Double(value.y)
            values.append(ChartDataEntry(x: x, y: y))
        }

        bodyView.historyView.setPrices(firstPrice: firsPrice, lastPrice: lastPrice)
        bodyView.historyView.setChartData(reference: ref, values: values)
        spinnerView.hide()
    }
    
    func marketPriceApiGetDidComplete(error: Error?) {
        spinnerView.hide()
    }
    
}