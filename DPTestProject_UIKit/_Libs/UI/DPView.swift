import Foundation
import UIKit

open class DPView: UIView {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupViews()
    }
    
    open func setupViews() {}
    
    open func updateViews() {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) { }

    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) { }
    
}
