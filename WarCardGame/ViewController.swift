//
//  ViewController.swift
//  WarCardGame
//
//  Created by Qatar Executive on 11/2/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView! {
      didSet {
        loadingView.layer.cornerRadius = 6
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        showSpinner()
        
        URLSession.shared.fetchData(at: url) { result in
            switch result {
            case .success(let data) :
                DispatchQueue.main.async {
                    print("Success:", data[0])
                }
            case .failure(let error):
                print("Error is:", error)
            }
            
            DispatchQueue.main.async {
                self.hideSpinner()
            }
            
        }
        
    }
    
    func fetchAPIGetData(URL url:String, completion: @escaping ([TodoModel]) -> Void){
        let url = URL(string: url)!
        let session = URLSession.shared
        let dataTask =  session.dataTask(with: url) { data, response, error in
            if data != nil && error == nil {
                do {
                    let parsingData = try JSONDecoder().decode([TodoModel].self, from: data!)
                    completion(parsingData)
                } catch {
                    print("Parsing error occured!")
                }
            }
        }
        dataTask.resume()
        
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
    }
    
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
}

extension URLSession {
    func fetchData(at url:URL, completion: @escaping(Result<[TodoModel], Error>) -> Void) {
        self.dataTask(with: url) { data, response, error in
            if data != nil && error == nil {
                do {
                    let fetchingData = try JSONDecoder().decode([TodoModel].self, from: data!)
                    print("Count ",fetchingData.count)
                    
                    completion(.success(fetchingData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
}

