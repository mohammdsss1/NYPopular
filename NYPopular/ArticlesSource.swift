import UIKit

protocol ArticlesSourceDelegate: class{
    func didSelectArticle(atRow: Int)
}

class ArticlesSource: NSObject {
    weak var articlesViewModel: ArticlesViewModel?
    weak var delegate: ArticlesSourceDelegate?
    
    init(articlesViewModel: ArticlesViewModel) {
        self.articlesViewModel = articlesViewModel
    }
}

extension ArticlesSource: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { articlesViewModel?.articles.count ?? 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article_cell") as! ArticleCell
        
        let article = articlesViewModel?.articles[indexPath.row]
        cell.configureWithArticle(article)
        return cell
    }
}

extension ArticlesSource: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectArticle(atRow: indexPath.row)
    }
}