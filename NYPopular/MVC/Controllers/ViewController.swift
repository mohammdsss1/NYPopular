import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var articlesViewModel = ArticlesViewModel()
    var source: ArticlesSource!
    
    private var detailedVC_: DetailesVC?
    private var detailedVC: DetailesVC{
        if detailedVC_ == nil{
            detailedVC_ = storyboard?.instantiateViewController(identifier: "details")
        }
        return detailedVC_!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        source = ArticlesSource(articlesViewModel: articlesViewModel)
        source.delegate = self
        tableView.delegate = source
        tableView.dataSource = source
        
        articlesViewModel.getMostPopularArticles(withPeriod: .one, success: { [weak self] articles in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }, failure: { error in
            print(error)
        })
    }
    
    override func didReceiveMemoryWarning() {
        detailedVC_ = nil
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: ArticlesSourceDelegate{
    func didSelectArticle(atRow: Int) {
        let article = articlesViewModel.articles[atRow]
        detailedVC.article = article
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}
