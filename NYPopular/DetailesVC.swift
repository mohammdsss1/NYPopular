import UIKit

final class DetailesVC: UIViewController {
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = article.title
    }
}
