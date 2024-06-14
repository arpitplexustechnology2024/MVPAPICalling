//
//  Presenter.swift
//  MVPAPICalling
//
//  Created by Arpit iOS Dev. on 13/06/24.
//

import Foundation
import Alamofire

protocol WordsPracticeView: AnyObject {
    func showWords(_ words: [Datum])
    func showError(_ error: Error)
    func showError(_ message: String)
}

class WordsPracticePresenter {
    private weak var view: WordsPracticeView?
    private let apiHalper: APIHalper
    
    init(view: WordsPracticeView, apiHalper: APIHalper = APIHalper()) {
        self.view = view
        self.apiHalper = apiHalper
    }
    
    func fetchWordsPracticeList(with keyName: String) {
        apiHalper.getWordsPracticeList(keyName: keyName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let welcome):
                    self?.view?.showWords(welcome.data)
                case .failure(let error):
                    self?.view?.showError(error)
                }
            }
        }
    }
}
