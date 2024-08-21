import UIKit

protocol CheckboxButtonDelegate: AnyObject {

    func checkboxButton(_ button: CheckboxButton, didChangeState isChecked: Bool)
}


class CheckboxButton: UIButton {
    
    // Properties to track the checkbox state
    public var isChecked: Bool = false {
        didSet {
            updateAppearance()
            notifyDelegate()
        }
    }
    
    weak var delegate: CheckboxButtonDelegate?
    
    private func notifyDelegate() {
        delegate?.checkboxButton(self, didChangeState: isChecked)
        print("Notifying delegate with state: \(isChecked)")
    }
    
    // Initialize the button
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        updateAppearance()
        print("CheckboxButton setup complete")
    }
    
    @objc private func toggleCheckbox() {
        isChecked.toggle()
    }
    
    private func updateAppearance() {
        let imageName = isChecked ? "checkbox" : "unchecked"
        if let image = UIImage(named: imageName) {
            let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 30, height: 30)) // Adjust target size as needed
            setImage(resizedImage, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit // Ensure image scales correctly
        }
    }

    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine what our scale should be
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Determine our new image size
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        // Resize the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
}
