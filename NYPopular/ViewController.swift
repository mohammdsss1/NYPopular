import UIKit

class ViewController: UIViewController {
    lazy var apiHandler = APIHandeler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiHandler.request(endPoint: EndPoint.mostPopular(period: "1")) { (result: Result<[Article], NetworkLayer.ErrorModel>) in
            switch result {
            case .success(let articles):
                print(articles)
            case .failure(let error):
                print(error)
            }
        }
    }
}

