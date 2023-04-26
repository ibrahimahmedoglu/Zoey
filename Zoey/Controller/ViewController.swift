//
//  ViewController.swift
//  Zoey
//
//  Created by ibrahim ahmedoglu on 25.04.2023.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.performSegue(withIdentifier: "logoToMain", sender: nil)
        }


    }
}
   

