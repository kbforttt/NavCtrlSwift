import UIKit

extension UIImageView {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    
    func load(urlString: String?) {
        
        if let urlString = urlString, let cachedImage = UIImageView.imageCache.object(forKey: urlString as NSString) {
           self.image = cachedImage
            return
        }
        
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
                        UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
                    }
                }
            }
        }
    }
}
