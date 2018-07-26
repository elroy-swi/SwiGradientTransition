//
//  ViewController.swift
//  SwiGradientTransitionDemo
//
//  Created by Elroy on 2018/7/26.
//  Copyright © 2018年 swi. All rights reserved.
//

import UIKit
import SwiGradientTransition
import EasyPeasy

class ViewController: UIViewController {

    lazy var gradientView: SwiGradientTransitionView = {
        let view = SwiGradientTransitionView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideChanged(_ sender: UISlider) {
        
    }

}

