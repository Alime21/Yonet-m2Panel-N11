import Foundation

protocol SearchInteractorProtocol {
    func fetchSearchResults()
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didFetchResults(_ results: [String])
}

class SearchInteractor: SearchInteractorProtocol {
    
    weak var presenter: SearchInteractorOutputProtocol?
    
    func fetchSearchResults() {
        // API ÇAĞRISI
        //ŞİMDİLİK UYDURMA
        let fakeResults = ["ali","veli","sss","ppp"]
        presenter?.didFetchResults(fakeResults)
    }
}

