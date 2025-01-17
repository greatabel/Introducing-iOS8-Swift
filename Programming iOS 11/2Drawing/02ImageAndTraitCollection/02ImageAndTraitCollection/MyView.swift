import UIKit

class MyView: UIView {
    var image: UIImage!

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        if var im = self.image {
            if let asset = self.image.imageAsset {
                im = asset.image(with: self.traitCollection)
            }
            im.draw(at: .zero)
        }
    }
}
