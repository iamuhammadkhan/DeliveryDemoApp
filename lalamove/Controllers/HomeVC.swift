//
//  HomeVC.swift
//  lalamove
//
//  Created by Muhammad Khan on 14/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    let segueDeliveryDetailsVC = "DeliveryDetailsVC"
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var delivery: Delivery!
    
    lazy var deliveries: [Delivery] = {
        let deliveries = [Delivery]()
        return deliveries
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "Things to Deliver"
        
        tableView.register(DeliveryCell.self, forCellReuseIdentifier: DeliveryCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let barHeight = UIApplication.shared.statusBarFrame.size.height + 44
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: barHeight).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.separatorColor = .clear
        
        getDeliveries()
    }
    
    private func getDeliveries() {
        
        DeliveriesAPIService.shared.getDeliveries { [weak self] (deliveries, error) in
            
            if let err = error {
                print("🔥 Error : ", err)
            } else {
                if let deliveries = deliveries {
                    print("🌎 Deliveries : ", deliveries.count)
                    self?.deliveries = deliveries
                    self?.reloadTableView()
                }
            }
        }
    }
    
    private func reloadTableView() {
        tableView.reloadData()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DeliveryDetailsVC {
            destination.delivey = delivery
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryCell.identifier, for: indexPath) as? DeliveryCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        if deliveries.count > 0 {
            
            let delivery = deliveries[indexPath.row]
            
            cell.populate(delivery)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delivery = deliveries[indexPath.row]
        performSegue(withIdentifier: segueDeliveryDetailsVC, sender: delivery)
    }
}
