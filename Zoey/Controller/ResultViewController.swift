//
//  ResultViewController.swift
//  Zoey
//
//  Created by ibrahim ahmedoglu on 25.04.2023.
//

import UIKit

class ResultViewController: UIViewController,  UITextViewDelegate {
    var result = String()

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.text = result
        
        

        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.y
            let visibleHeight = scrollView.bounds.size.height
            let contentHeight = scrollView.contentSize.height
            let middleOffset = (contentHeight - visibleHeight) / 2
            
            if offset > middleOffset {
                navigationController?.popViewController(animated: true)
                showAlert()
            }
        }

        func showAlert() {
            let alertController = UIAlertController(title: "Subscription Required", message: "To continue, you must have a subscription.", preferredStyle: .alert)

            let subAction = UIAlertAction(title: "Subscribe", style: .default) { (action) in
                
                if let url = URL(string: "https://boby.ai/") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alertController.addAction(subAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
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
