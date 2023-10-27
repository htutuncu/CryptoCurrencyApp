//
//  CryptoCell.swift
//  CryptoCurrencyApp
//
//  Created by Hikmet Tütüncü on 26.10.2023.
//

import Foundation
import UIKit

class CryptoCell: UITableViewCell {
    
    let currencyName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        return label
    }()
    
    let price : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    func createUI() {
        contentView.backgroundColor = .clear
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        contentView.addSubview(view)
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 4).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -4).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -4).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4).isActive = true
        
        price.font = .systemFont(ofSize: 22, weight: .black)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textColor = .white
        price.textAlignment = .left
        price.numberOfLines = 1
        view.addSubview(price)
        price.bottomAnchor.constraint(equalTo: view.centerYAnchor,constant: 0).isActive = true
        price.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8).isActive = true
        price.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
            
        currencyName.font = .systemFont(ofSize: 18, weight: .regular)
        currencyName.translatesAutoresizingMaskIntoConstraints = false
        currencyName.textColor = .white
        currencyName.textAlignment = .right
        currencyName.numberOfLines = 1
        view.addSubview(currencyName)
        currencyName.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 4).isActive = true
        currencyName.leadingAnchor.constraint(equalTo: price.leadingAnchor).isActive = true
        currencyName.trailingAnchor.constraint(equalTo: price.trailingAnchor).isActive = true
        }
    
    func setup(indexPath: IndexPath, cryptos: [Crypto]){
        price.text = cryptos[indexPath.row].price
        currencyName.text = cryptos[indexPath.row].currency
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
