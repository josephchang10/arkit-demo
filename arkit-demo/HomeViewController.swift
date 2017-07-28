//
//  HomeViewController.swift
//  arkit-demo
//
//  Created by 张嘉夫 on 2017/7/28.
//  Copyright © 2017年 张嘉夫. All rights reserved.
//

import UIKit
import ARKit

private let cellIdentifier = "Cell"

class HomeViewController: UITableViewController {

    private var options = [Option]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ARKit Demo"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        options = [
            Option(title: "简单图形", vc: SimpleShapeViewController.self)
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !ARSessionConfiguration.isSupported {
            let alert = UIAlertController(title: "设备不支持", message: "抱歉，此 App 只能在支持 ARKit 的设备上运行。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = options[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vcType = options[indexPath.row].vc
        let vc = vcType.init()
        navigationController?.pushViewController(vc, animated: true)
    }

}

private struct Option {
    let title: String
    let vc: UIViewController.Type
}
