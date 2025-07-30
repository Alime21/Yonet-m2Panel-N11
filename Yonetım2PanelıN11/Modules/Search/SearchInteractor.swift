import Foundation

protocol SearchInteractorProtocol {
    func fetchSearchResults()
    func search(query: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didFetchResults(_ results: [String])
}

class SearchInteractor: SearchInteractorProtocol {
    
    weak var presenter: SearchInteractorOutputProtocol?
    
    func search(query: String) { 
            let filteredResults = ["\(query) sonucu 1", "\(query) sonucu 2"]
            presenter?.didFetchResults(filteredResults)
        }
    
    func fetchSearchResults() {
        // API ÇAĞRISI
        //ŞİMDİLİK UYDURMA
        let fakeResults = ["ali","veli","sss","ppp"]
        presenter?.didFetchResults(fakeResults)
    }
}

