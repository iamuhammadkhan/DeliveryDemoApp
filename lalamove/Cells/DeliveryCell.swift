//
//  DeliveryCell.swift
//  lalamove
//
//  Created by Muhammad Khan on 14/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

class DeliveryCell: UITableViewCell {

    private let cardView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 5
        cv.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0.1176470588, alpha: 1)
        cv.layer.shadowRadius = 4
        cv.layer.shadowOpacity = 0.3
        cv.layer.shadowOffset = CGSize(width: -2, height: 0.5)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let itemImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "placeholder")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let itemName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Halvetica", size: 24)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0.1176470588, alpha: 1)
        label.text = "Delivery documents to Andrio at Mong Kok"
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemName.text?.removeAll()
        itemImage.image = UIImage(named: "placeholder")
    }
    
    private func setupViews() {
        
        addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        
        cardView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        
        itemImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        stackView.addArrangedSubview(itemImage)
        stackView.addArrangedSubview(itemName)
    }
    
    func populate(_ delivery: Delivery) {
        
        itemName.text = delivery.description
    
        itemImage.setImageWithUrl(with: delivery.imageUrl)
    }
}
