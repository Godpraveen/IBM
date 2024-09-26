//
//  AddCategoryVC.swift
//  SAMPLE TASK
//
//  Created by Toqsoft on 28/05/24.
//

import UIKit

protocol AddCategoryVCDelegate : AnyObject {
    func didCompletePUTRequest()
}
class AddCategoryVC: UIViewController {
    
    weak var delegate : AddCategoryVCDelegate?
    var apidata : WelcomeElement?
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var rowId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTxt.text = ""
    }
    
    @IBAction func xBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
    
        // Ensure required text fields have values
        guard
           
              let codeText = code.text,
              let nameText = name.text,
              let descriptionText = descriptionTxt.text else {
            print("Invalid input data")
            return
        }
        
        // Define the URL
        guard let url = URL(string: "https://apinatco.azurewebsites.net/api/Products?customQuery=") else {
            print("Invalid URL")
            return
        }
        
        // Create a URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue("Bearer your_access_token", forHTTPHeaderField: "Authorization")
        
        // Create the JSON payload
        let parameter : [String: Any] = [
           
            "description": descriptionText,
            "code": codeText,
            "categoryname": nameText
        ]
        
        // Serialize the JSON payload
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making PUT request: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }
            
            if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                print("Response data: \(responseBody)")
            }
            DispatchQueue.main.async {
                self.delegate?.didCompletePUTRequest()
            }
        }
        
        // Start the task
        task.resume()
    }
}
