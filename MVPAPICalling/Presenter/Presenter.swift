//
//  Presenter.swift
//  MVPAPICalling
//
//  Created by Arpit iOS Dev. on 13/06/24.
//
import Foundation

protocol WordsPracticeView: AnyObject {
    func showWords(_ words: [Datum])
    func showError(_ error: Error)
    func showError(_ message: String)
}

class WordsPracticePresenter {
    weak var view: WordsPracticeView?
    private let networkService: NetworkService
    
    init(view: WordsPracticeView, networkService: NetworkService = NetworkService()) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchWordsPracticeList(with keyName: String) {
        networkService.getWordsPracticeList(keyName: keyName) { [weak self] result in
            switch result {
            case .success(let welcome):
                DispatchQueue.main.async {
                    self?.view?.showWords(welcome.data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(error)
                }
            }
        }
    }
}
