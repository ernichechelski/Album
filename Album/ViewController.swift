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
    
    
    var selectedIndexPath: IndexPath!
    var currentLeftSafeAreaInset  : CGFloat = 0.0
    var currentRightSafeAreaInset : CGFloat = 0.0
    
    var disposeBag = DisposeBag()
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<MySection>?

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<MySection>(configureCell: {
            dataSource,
            collectionView,
            indexPath,
            item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
                //cell.imageView.backgroundColor = .red
            
            cell.imageView.af_setImage(withURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/39a21dbce23801f4efe8946cccb9b560/250x250-000000-80-0-0.jpg")!,completion: { (response) in
                cell.sizeToFit()
            })
            cell.imageView.motionIdentifier = "photo_\(indexPath.item)"
                return cell
            }
        )
        
        imagesCollectionView.setContentOffset(imagesCollectionView.contentOffset, animated:true)
        let sections = [
            MySection(header: "First section", items: [
                1,
                2,3,4,5,6,7,8,9,10,11
                ]),
            MySection(header: "First section", items: [
                1,
                2
                ])
        ]
        
        let observable =  Observable.just(sections)
        imagesCollectionView.rx.modelSelected(Int.self).asObservable().subscribe(onNext: { (item) in
            
            
        }).disposed(by: disposeBag)
        
        
        observable
            .bind(to: imagesCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
     
    }   
}
