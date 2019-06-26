import UIKit

extension UIImageView {
    func load(urlString: String?) {
        
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.image = UIImage(named: "placeholder.png")
        
        guard let urlString = urlString else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image.stretchableImage(withLeftCapWidth: (self?.image?.leftCapWidth)!, topCapHeight: (self?.image?.topCapHeight)!)
                        //self?.image = image
                    }
                }
            }
        }
    }
}
