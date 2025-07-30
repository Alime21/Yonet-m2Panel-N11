//the brain that manages the work on the view
import Foundation
import UIKit

protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapKayıttakiler()
}

class DashboardPresenter: DashboardPresenterProtocol {
    
    weak var view: DashboardViewController?
    var interactor: DashboardInteractorProtocol?
    var router: DashboardRouterProtocol?
    
    func viewDidLoad() {
        print("Dashboard loaded.")
        
        //buradan veri çekmeyi başlat
    }
    
    //search sayfasına gitmeyi sağlayan buton aksiyonu
    //viewcontrollerdan basılan fonksiyon buraya yönlendirir; burda da presenter router'a yönlendirdi
    func didTapKayıttakiler() {
        print("Presenter didTapKayıttakiler tetiklendi ")
        guard let view = view as? UIViewController else {
                print("Presenter.view nil!")
                return
            }
            //guard let router = router else {
              //  print("Presenter.router nil!")
                //return
            //}
            router?.navigateToSearch(from: view)
    }
    
    
}



