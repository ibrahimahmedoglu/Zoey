//
//  GenerateViewController.swift
//  Zoey
//
//  Created by ibrahim ahmedoglu on 25.04.2023.
//

import UIKit
import OpenAISwift

class GenerateViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func generateAct(_ sender: Any) {
        
        performSegue(withIdentifier: "GenerateToResult", sender: filtered[0][2])
    }
    
    @IBAction func openAIAct(_ sender: Any) {
        
        performSegue(withIdentifier: "GenerateToResult", sender: openAIResult)
    }

    @IBOutlet weak var openAIBtn: UIButton!
    @IBOutlet weak var generateBtn: UIButton!
    var traits = [String]()
    var ageNo: String?
    var preferences = [[String]]()
    var filtered = [[String]]()
    var openAIResult = String()

    
    override func viewDidLoad()  {
        super.viewDidLoad()
        openAIBtn.isEnabled = false
        generateBtn.layer.cornerRadius = 10
        openAIBtn.layer.cornerRadius = 10
        decodeAPI()
        askOpenAI()
        Timer.scheduledTimer(withTimeInterval: 13.0, repeats: false) { timer in
            self.openAIBtn.isEnabled = true
        }
        


        
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GenerateToResult" {
            if let data = sender as? String {
                let vc = segue.destination as! ResultViewController
                vc.result = data
            }
        }
       
    }
    
    func decodeAPI(){
        guard let url = URL(string: "https://sheets.googleapis.com/v4/spreadsheets/1lODDN4mU5e0O_ET6oJggXgkduD2E3bY4IW7l0-QgZRE/values/sayfa1?key=AIzaSyAGG4piOVh_PXb4XGv6mJ_UhVluBF5BQ-E") else{return}

        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()

            if let data = data{
                do{
                    let tasks = try decoder.decode(Preferences.self, from: data)
                    self.preferences =  tasks.values!
                    self.filterResult(values: tasks.values!)
                   
                    
                }catch{
                    print(error)
                }
            }
        }
        task.resume()

    }
    
    
    func askOpenAI() {
        let apiKey = ""
        let openAI = OpenAISwift(authToken: apiKey)
        var traitsString = ""
        for trait in traits {
            traitsString.append(trait)
            traitsString.append(", ")
        }
        var prompt = readPrompt()
        prompt.append("Generate a story with the traits of \(traitsString) for a kid at the age of \(ageNo!)? Start with the Answer")
        
        print(prompt)
        
        
        openAI.sendCompletion(with: prompt, maxTokens: 400) { result in // Result<OpenAI, OpenAIError>
            switch result {
            case .success(let success):
                print(success.choices?.first?.text ?? "")
                self.openAIResult.append(success.choices?.first?.text ?? "")
               
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func readPrompt() -> String {
        if let fileURL = Bundle.main.url(forResource: "../prompt", withExtension: "txt") {
            do {
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                return fileContents
            } catch {
                return"Error reading file: \(error)"
            }
        } else {
            return "File not found"
        }
    }

    
    
    func filterResult(values: [[String]]){
        
        
        if(traits.count == 1){
            filtered = values.filter { value in
            return value[1] == traits[0] && value[0] == ageNo
                
            }
           
        }
        else if(traits.count == 2){
            filtered = values.filter { value in
                return (value[1] == "\(traits[0]), \(traits[1])" || value[1] == "\(traits[1]), \(traits[0])") && value[0] == ageNo
            }
            
        }
        else if(traits.count == 3){
            filtered = values.filter { value in
            return value[1] == "patience, sharing, respect" && value[0] == ageNo
            }
            
        }
            
        
       
        
    }
}

