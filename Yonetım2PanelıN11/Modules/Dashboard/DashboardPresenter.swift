//the brain that manages the work on the view
import Foundation

protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class DashboardPresenter: DashboardPresenterProtocol {
    
    weak var view: DashboardViewController?
    var interactor: DashboardInteractorProtocol?
    var router: DashboardRouterProtocol?
    
    func viewDidLoad() {
        print("Dashboard loaded.")
        
        //buradan veri çekmeyi başlat
    }
}



