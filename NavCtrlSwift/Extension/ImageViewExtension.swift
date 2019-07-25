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
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    NSLog("Image Loaded %@", urlString)
                    DispatchQueue.main.async {
                        self.image = image
                        UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
                    }
                }
            }
        }
    }
}
