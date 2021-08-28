import Foundation
import UIKit

open class DPTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Init
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.setupViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupViews()
    }

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.setupViews()
    }

    open func setupViews() {}

    open func updateViews() {}
    
    open func setupModel(_ model: Any?) {}

    @objc
    open func tapButtonHandler(_ button: UIButton) {}

    @objc
    open func tapGestureHandler(_ gesture: UITapGestureRecognizer) {}
    
}
