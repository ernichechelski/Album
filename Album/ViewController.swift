//
//  ViewController.swift
//  Album
//
//  Created by Ernest Chechelski on 13/04/2019.
//  Copyright © 2019 Ernest Chechelski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Motion
class ViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var rightSwitch: UISwitch!
    @IBOutlet weak var leftSwitch: UISwitch!
    
    var disposeBag = DisposeBag()
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<MySectionViewModel>?
    var networkDataSource:MySectionDataSource = DataProvider().getSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = RxCollectionViewSectionedAnimatedDataSource<MySectionViewModel>(configureCell: {
            dataSource,
            collectionView,
            indexPath,
            item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
            cell.imageView.af_setImage(withURL: URL(string:item)!,placeholderImage: UIImage.init(named: "no_cover.jpg"))
                return cell
            }
        )
        let observable = networkDataSource.dataObservable()
            
            observable.bind(to: imagesCollectionView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
     
        
        
        Observable.combineLatest(leftSwitch.rx.isOn,
                             rightSwitch.rx.isOn
        ,imagesCollectionView.rx.modelSelected(String.self).asObservable()).subscribe(onNext: { (left,right,item) in
            
            if left && right {
                let alert = UIAlertController(title: "You selected this url", message:item,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        
        }).disposed(by: disposeBag)
    }   
}
