import UIKit

final class ArticleCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var byLine: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    
    func configureWithArticle(_ article: Article?){
        icon.image = nil
        title.text = article?.title ?? ""
        byLine.text = article?.byline ?? ""
        publishDate.text = article?.publishedDate ?? ""
    }
}
