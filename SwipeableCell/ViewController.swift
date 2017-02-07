//
//  ViewController.swift
//  SwipeableCell
//
//  Created by Matt Beaney on 07/02/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(SwipeableConformant.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: SwipeableConformant = tableView.dequeueReusableCell(withIdentifier: "cell") as? SwipeableConformant {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.configure()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}

