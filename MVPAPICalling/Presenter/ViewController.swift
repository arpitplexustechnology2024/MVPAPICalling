//
//  ViewController.swift
//  MVPAPICalling
//
//  Created by Arpit iOS Dev. on 13/06/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WordsPracticePresenter!
    private var words: [Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let keyName = textField.text, !keyName.isEmpty else {
            showError("Please enter text")
            return
        }
        presenter.fetchWordsPracticeList(with: keyName)
    }
    
    func showWords(_ words: [Datum]) {
        self.words = words
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    
}

