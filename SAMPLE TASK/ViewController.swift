//
//  ViewController.swift
//  SAMPLE TASK
//
//  Created by Toqsoft on 24/05/24.
//

import UIKit

class ViewController: UIViewController , SecondViewControllerDelegate , AddCategoryVCDelegate{
 
    var rowid : Int  = 0
    var getSpace : String = "        "
    var apidata : [WelcomeElement]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
        tableView.delegate = self
        tableView.dataSource = self
       
        
    }
    @IBAction func addButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Addvc = storyboard.instantiateViewController(withIdentifier: "addCategoryVC")as! AddCategoryVC
       Addvc.modalTransitionStyle = .crossDissolve
        self.present(Addvc, animated: true)
        
    
    }
    
    func data (){
        let url = URL(string: "https://apinatco.azurewebsites.net/api/Products?customQuery=")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            let decode = JSONDecoder()
            do{
                let result = try decode.decode([WelcomeElement].self, from: data!)
                DispatchQueue.main.async {
                    self.apidata = result
                    self.tableView.reloadData()
                }
                print(" response  : \(result)")
            }catch{
                print(error)
            }
        }.resume()
        
    }
    
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController")as! SecondViewController
        vc.apidata = apidata?[indexPath.row]
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apidata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let value = apidata?[indexPath.row]
        cell.Rowid.text = "\(value?.rowid ?? 0)"
        cell.CreatedBy.text = "\(getSpace)\(value?.createdby ?? "")"
        cell.CategoryName.text = "\(value?.name ?? "")"
        cell.Code.text = "\(getSpace)\(value?.code ?? "")"
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let  headerView = Bundle.main.loadNibNamed("ViewFoeHeader", owner: self, options: nil)?.first as? ViewFoeHeader else {
            return nil
       }
       return headerView
    }
    
    
    func didCompletePUTRequest() {
        data()
        tableView.reloadData()
    }
    
    
}
