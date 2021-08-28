import Foundation
import UIKit

open class DPTableViewCell: UITableViewCell {
    
    // MARK: - Init
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
    open func tapButtonAction(_ button: UIButton) { }

    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}

