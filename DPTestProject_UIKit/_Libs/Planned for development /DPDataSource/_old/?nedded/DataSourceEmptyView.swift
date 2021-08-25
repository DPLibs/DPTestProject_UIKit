//import Foundation
//import UIKit
//
//public protocol DataSourceEmptyView: DataSourceAdapterPlugin {
//    func append(to table: UITableView?)
//    func append(to collection: UICollectionView?)
//}
//
//public extension DataSourceEmptyView where Self: UIView {
//    
//    private func createBackgroundView() -> UIView {
//        self.isHidden = true
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = .clear
//        backgroundView.addSubview(self)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.topAnchor.constraint(equalTo: backgroundView.topAnchor),
//            self.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
//            self.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
//            self.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
//        ])
//        return backgroundView
//    }
//    
//    func append(to table: UITableView?) {
//        table?.backgroundView = self.createBackgroundView()
//    }
//    
//    func append(to collection: UICollectionView?) {
//        collection?.backgroundView = self.createBackgroundView()
//    }
//    
//}
//
//public protocol DataSourceEmptyViewPresentable {
//    var backgroundView: UIView? { get set }
//    
//    func showDataSourceEmptyView()
//    func hideDataSourceEmptyView()
//    func updateDataSourceEmptyView(isHidden: Bool)
//}
//
//public extension DataSourceEmptyViewPresentable {
//    
//    func showDataSourceEmptyView() {
//        guard let view = self.backgroundView?.subviews.first(where: { $0 is DataSourceEmptyView }) else { return }
//        view.isHidden = false
//    }
//    
//    func hideDataSourceEmptyView() {
//        self.backgroundView?.subviews.forEach({ view in
//            if view is DataSourceEmptyView {
//                view.isHidden = true
//            }
//        })
//    }
//    
//    func updateDataSourceEmptyView(isHidden: Bool) {
//        if isHidden {
//            self.hideDataSourceEmptyView()
//        } else {
//            self.showDataSourceEmptyView()
//        }
//    }
//    
//}
//
//extension UITableView: DataSourceEmptyViewPresentable {}
//extension UICollectionView: DataSourceEmptyViewPresentable {}
