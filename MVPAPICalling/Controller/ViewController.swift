//
//  ViewController.swift
//  MVPAPICalling
//
//  Created by Arpit iOS Dev. on 13/06/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController, WordsPracticeView {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WordsPracticePresenter!
    private var words: [Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "stenoTableViewCell", bundle: nil), forCellReuseIdentifier: "stenoTableViewCell")
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let keyName = textField.text, !keyName.isEmpty else {
            showError("Please enter text")
            return
        }
        presenter = WordsPracticePresenter(view: self)
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

// MARK: - TableView Dalegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "stenoTableViewCell") as! stenoTableViewCell
            
            return Cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.customeGray
            }
            let datum = words[indexPath.row]
            cell.idLbl.text = datum.id
            cell.nameLbl.text = datum.name
            switch datum.extPath {
            case .pdf:
                cell.extPathIcon.image = UIImage(named: "pdf")
            case .mp4:
                cell.extPathIcon.image = UIImage(named: "audio")
            default:
                cell.extPathIcon.image = nil
            }
            cell.extPath1Lbl.text = datum.extPath1
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 57
        } else {
            return 65
        }
    }
}
