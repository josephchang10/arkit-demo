//
//  SimpleShapeViewController.swift
//  arkit-demo
//
//  Created by 张嘉夫 on 2017/7/28.
//  Copyright © 2017年 张嘉夫. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class SimpleShapeViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "简单图形"
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.antialiasingMode = .multisampling4X
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingSessionConfiguration.isSupported {
            let configuration = ARWorldTrackingSessionConfiguration()
            sceneView.session.run(configuration)
        } else if ARSessionConfiguration.isSupported {
            let configuration = ARSessionConfiguration()
            sceneView.session.run(configuration)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showHelperAlertIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - UI Events
    
    @IBAction func tapScreen() {
        if let camera = sceneView.pointOfView {
            let sphere = NodeGenerator.generateSphereInFrontOf(node: camera)
            sceneView.scene.rootNode.addChildNode(sphere)
            print("向场景中添加了球")
        }
    }
    
    @IBAction func twoFingerTapScreen() {
        if let camera = sceneView.pointOfView {
            let cube = NodeGenerator.generateCubeInFrontOf(node: camera, physics: false)
            sceneView.scene.rootNode.addChildNode(cube)
            print("向场景中添加方块")
        }
    }
    
    
    // MARK: - Private Methods
    
    private func showHelperAlertIfNeeded() {
        let key = "SimpleShapeViewController.helperAlert.didShow"
        if !UserDefaults.standard.bool(forKey: key) {
            let alert = UIAlertController(title: "简单图形", message: "轻点会在世界里锚定一个球。2 指轻点会在世界里锚定一个方块。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            UserDefaults.standard.set(true, forKey: key)
        }
    }

}
