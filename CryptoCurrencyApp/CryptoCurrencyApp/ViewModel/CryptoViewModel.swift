//
//  CryptoViewModel.swift
//  CryptoCurrencyApp
//
//  Created by Hikmet Tütüncü on 26.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func fetchData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .urlError:
                    self.error.onNext("Wrong URL")
                case .decodingError:
                    self.error.onNext("Error on decoding")
                case .serverError:
                    self.error.onNext("Error on server")
                }
            }
            self.loading.onNext(false)
        }
    }
}
