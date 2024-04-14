import UIKit

extension UIImageView {
    func loadCachedImage(of key: String) {
        if let cachedImage = ImageCacheManager.getObject(forKey: key) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            guard
                let url = URL(string: key),
                var urlCompoentns = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { return }
            
            urlCompoentns.scheme = "https"
            
            guard
                let imageURL = urlCompoentns.url,
                let imageData = try? Data(contentsOf: imageURL),
                let loadedImage = UIImage(data: imageData)
            else { return }
            
            ImageCacheManager.setObject(image: loadedImage, forKey: key)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = loadedImage
            }
        }
    }
}

final class ImageCacheManager {
    // MARK: - Properties
    static let shared = NSCache<NSString, UIImage>()
    private let memoryWarningNotification = UIApplication.didReceiveMemoryWarningNotification
    
    // MARK: - Initializers
    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(removeAll),
            name: memoryWarningNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: memoryWarningNotification, object: nil)
    }
    
    // MARK: - Methods
    static func getObject(forKey key: String) -> UIImage? {
        let cacheKey = NSString(string: key)
        let cachedImage = shared.object(forKey: cacheKey)
        return cachedImage
    }
    
    static func setObject(image: UIImage, forKey key: String) {
        let cacheKey = NSString(string: key)
        shared.setObject(image, forKey: cacheKey)
    }
    
    @objc
    private func removeAll() {
        ImageCacheManager.shared.removeAllObjects()
    }
}
