import UIKit

class ViewController: UIViewController {
    lazy var articlesManager: ArticlesService = ArticlesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesManager.getMostPopularArticles(withPeriod: "1") { result in
            switch result {
            case .success(let articles):
                print(articles)
            case .failure(let error):
                print(error)
            }
        }
    }
}

