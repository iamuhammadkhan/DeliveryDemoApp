//
//  DeliveryDetailsVC.swift
//  lalamove
//
//  Created by Muhammad Khan on 14/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailsVC: UIViewController {

    let mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = .standard
        mv.isScrollEnabled = true
        mv.isZoomEnabled = true
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    let cardView: UIView = {
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
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let itemImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "placeholder")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Halvetica", size: 24)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0.1176470588, alpha: 1)
        label.text = "Delivery documents to Andrio at Mong Kok"
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var delivey: Delivery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = "Delivery Details"
        
        view.addSubview(cardView)
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        
        cardView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        
        itemImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        stackView.addArrangedSubview(itemImage)
        stackView.addArrangedSubview(itemName)
        
        let barHeight = UIApplication.shared.statusBarFrame.size.height + 44
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: barHeight).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -16).isActive = true
        
        populateData()
    }
    
    private func populateData() {
        
        if let delivery = delivey {
            
            itemName.text = delivery.description
            
            itemImage.setImageWithUrl(with: delivery.imageUrl)
            
            let location = CLLocationCoordinate2D(latitude: delivery.location.lat, longitude: delivery.location.lng)
            let viewRegion = MKCoordinateRegionMakeWithDistance(location, 1200, 1200)
            mapView.setRegion(viewRegion, animated: false)
            
            let annotation = MKPointAnnotation()
            annotation.title = delivery.location.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: delivery.location.lat, longitude: delivery.location.lng)
            mapView.addAnnotation(annotation)
        }
    }
}
