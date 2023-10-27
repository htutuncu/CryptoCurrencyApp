//
//  ViewController.swift
//  CryptoCurrencyApp
//
//  Created by Hikmet Tütüncü on 26.10.2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cryptoTableView = UITableView()
    var cryptos: [Crypto]?
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupIndicator()
        setupBindings()
        cryptoVM.fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cryptoCell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell", for: indexPath) as! CryptoCell
        cryptoCell.setup(indexPath: indexPath, cryptos: cryptos!)
        return cryptoCell
    }
    
    func setupBindings() {
        _ = cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { cryptoData in
                self.cryptos = cryptoData
                self.cryptoTableView.isHidden = false
                self.cryptoTableView.reloadData()
            }).disposed(by: disposeBag)
        
        _ = cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { error in
                print(error)
            }).disposed(by: disposeBag)
        
        _ = cryptoVM
            .loading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { isLoading in
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
    
    func setupIndicator() {
        view.backgroundColor = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cryptoTableView.translatesAutoresizingMaskIntoConstraints = false
        cryptoTableView.delegate = self
        cryptoTableView.dataSource = self
        cryptoTableView.backgroundColor = .white
        cryptoTableView.rowHeight = 80
        cryptoTableView.register(CryptoCell.self, forCellReuseIdentifier: "cryptoCell")
        cryptoTableView.isHidden = true
        view.addSubview(cryptoTableView)
        cryptoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cryptoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cryptoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cryptoTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

