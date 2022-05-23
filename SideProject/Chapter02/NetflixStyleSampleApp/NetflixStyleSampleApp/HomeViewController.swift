//
//  HomeCollectionViewController.swift
//  NetflixStyleSampleApp
//
//  Created by 전성규 on 2022/05/22.
//

import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController {
    
    var contents: [Content] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar Custom
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        //Navigation Bar Button Setting
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
        //Data Setting
        contents = getContent()
        
        //CollectionView Item(Cell) Setting
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewCell")
        collectionView.collectionViewLayout = self.layout()
    }
    
    func getContent() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        
        return list
    }
    
    //각각의 Section Type에 대한 UICollectionViewLayout 생성
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, enviromnet -> NSCollectionLayoutSection? in
            guard let self = self else { return nil}
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSeciont()
                
            default:
                return nil
            }
        }
    }
    
    private func createBasicTypeSeciont() -> NSCollectionLayoutSection {
        //item
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                       , subitem: item
                                                       , count: 3)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHaeder()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    //Section Header Layout Setting
    private func createSectionHaeder() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Header Size
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(30))
        
        //Section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        return sectionHeader
    }
}

//UICollectionView DatatSource, Delegate Setting
extension HomeViewController {
    
    //Section당 보여질 Cell 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //임시 설정
        if contents[section].sectionType == .basic {
            switch section {
            case 0:
                return 1  //첫 번째 Section에서는 하나의 Cell만 표시
                
            default:
                return contents[section].contentItem.count
            }
        }
        return 0
    }
    
    //CollectionView Cell Setting
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    //Header View Setting
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header") }
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            
            return headerView
        } else {
            
            return UICollectionReusableView()
        }
    }
    
    //Section Count Setting
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return contents.count
    }
    
    //Cell Select
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("TEST: \(sectionName)섹션의 \(indexPath.row + 1)번째 Content")
    }
}

//SwiftUI PreView
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            do {}
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
