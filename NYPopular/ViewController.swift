import UIKit

class ViewController: UIViewController {
    lazy var articlesViewModel = ArticlesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesViewModel.getMostPopularArticles(withPeriod: "1", success: { articles in
            
        }, failure: { error in
            
        })
    }
}

