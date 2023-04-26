//
//  AgeViewController.swift
//  Zoey
//
//  Created by ibrahim ahmedoglu on 25.04.2023.
//

import UIKit

class AgeViewController: UIViewController {

    @IBAction func option1st(_ sender: Any) {
        performSegue(withIdentifier: "MainToPreferences", sender: "3")
    }
    @IBAction func option2nd(_ sender: Any) {
        performSegue(withIdentifier: "MainToPreferences", sender: "4")
    }
    @IBOutlet weak var option2nd: UIButton!
    @IBOutlet weak var option1st: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        option1st.layer.cornerRadius = 15
        
        option2nd.layer.cornerRadius = 15
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToPreferences" {
            if let data = sender as? String {
                let vc = segue.destination as! PreferencesViewController
                vc.ageNo = data
            }
        }
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
