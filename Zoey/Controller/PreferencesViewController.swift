//
//  PreferencesViewController.swift
//  Zoey
//
//  Created by ibrahim ahmedoglu on 25.04.2023.
//

import UIKit

class PreferencesViewController: UIViewController {
    @IBOutlet weak var alertLabel: UILabel!
    var traits = [String]()
    @IBOutlet weak var SharingOutlet: UIButton!
    @IBOutlet weak var PatienceOutlet: UIButton!
    @IBOutlet weak var RespectOutlet: UIButton!
    @IBOutlet weak var ContinueOutlet: UIButton!
    @IBAction func RespectBtn(_ sender: Any) {
        if(RespectOutlet.tintColor.accessibilityName == "gray"){
            RespectOutlet.tintColor = UIColor(red: 241, green: 246, blue: 249, alpha: 1.0)
            traits.append("respect")
            print(traits)
        } else{
            RespectOutlet.tintColor = UIColor.gray
            traits = traits.filter(){$0 != "respect"}
        }
    }
    @IBAction func ContinueBtn(_ sender: Any) {
        if(traits.isEmpty){
            alertLabel.isHidden = false
        } else{
            performSegue(withIdentifier: "PreferencesToGenerate", sender: traits)
            alertLabel.isHidden = true
        }
        
    }
    @IBAction func PatienceBtn(_ sender: Any) {
        if(PatienceOutlet.tintColor.accessibilityName == "gray"){
            PatienceOutlet.tintColor = UIColor(red: 241, green: 246, blue: 249, alpha: 1.0)
            traits.append("patience")
            print(traits)
        } else{
            PatienceOutlet.tintColor = UIColor.gray
            traits = traits.filter(){$0 != "patience"}
        }
    }
    @IBAction func SharingBtn(_ sender: Any) {
        if(SharingOutlet.tintColor.accessibilityName == "gray"){
            SharingOutlet.tintColor = UIColor(red: 241, green: 246, blue: 249, alpha: 1.0)
            traits.append("sharing")
            print(traits)
        } else{
            SharingOutlet.tintColor = UIColor.gray
            traits = traits.filter(){$0 != "sharing"}
        }
    }
    var ageNo: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        ContinueOutlet.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PreferencesToGenerate" {
            if let data = sender as? [String] {
                let vc = segue.destination as! GenerateViewController
                vc.traits = data
                vc.ageNo = ageNo
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
