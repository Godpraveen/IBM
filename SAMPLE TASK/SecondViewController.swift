//
//  SecondViewController.swift
//  SAMPLE TASK
//
//  Created by Toqsoft on 27/05/24.
//

import UIKit
// Define the protocol
protocol SecondViewControllerDelegate: AnyObject {
    func didCompletePUTRequest()
}

class SecondViewController: UIViewController {
    weak var delegate: SecondViewControllerDelegate?
    
    var apidata : WelcomeElement?
    @IBOutlet weak var Rowidtxt: UITextField!
    
    @IBOutlet weak var nametxt: UITextField!
    
    @IBOutlet weak var codetxt: UITextField!
    
    @IBOutlet weak var descriptiontxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        nametxt.text = apidata?.name
        codetxt.text = apidata?.code
        descriptiontxt.text = apidata?.description
        
    }
    
  
    @IBAction func updateBtn(_ sender: UIButton) {
    
    
    presentAlert()
       

        // Define the URL
        guard let url = URL(string: "https://apinatco.azurewebsites.net/api/Products?customQuery=") else {
            print("Invalid URL")
            return
        }

        // Create a URLRequest object
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        // Set headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.setValue("Bearer your_access_token", forHTTPHeaderField: "Authorization")

        // Create the JSON payload
        let parameters: [String: Any] = [
            
            "id": apidata?.id ?? 0,
            "partitionKey": apidata?.partitionKey ?? 0,
            "rowid": apidata?.rowid ?? 0,
            "createddate": apidata?.createddate ?? "",
            "createdby": apidata?.createdby ?? "",
            "name":nametxt.text!,
            "code":codetxt.text!,
            "sku": apidata?.sku ?? "",
            "description": descriptiontxt.text!,
            "image": apidata?.image ?? "",
            "categoryid": apidata?.categoryid ?? "",
            "categoryname": apidata?.categoryname ?? "",
            "subcategoryid": apidata?.subcategoryid ?? "",
            "subcategoryname": apidata?.subcategoryname ?? "",
            "brandid": apidata?.brandid ?? "",
            "brandname": apidata?.brandname ?? "",
            "unitid": apidata?.unitid ?? "",
            "unitname": apidata?.unitname ?? "",
            "reorderlevel":apidata?.reorderlevel ?? "",
            "availableqty": apidata?.availableqty ?? "",
            "status": apidata?.status ?? ""
                
        ]

        // Serialize the JSON payload
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
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
    func presentAlert() {
           // Step 1: Create the alert controller
           let alertController = UIAlertController(title: "ALERT", message: "Updated Successfully", preferredStyle: .alert)

           // Step 2: Add actions to the alert
           let okAction = UIAlertAction(title: "OK", style: .default) { _ in
               print("OK button tapped")
           }
           alertController.addAction(okAction)

           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
               print("Cancel button tapped")
           }
           alertController.addAction(cancelAction)

           // Step 3: Present the alert
           self.present(alertController, animated: true, completion: nil)
       }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func xBtn(_ sender: Any) {
        
        self.dismiss(animated: true)

    }
}


