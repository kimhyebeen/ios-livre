//
//  BookCollectionField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

protocol BookCollectionFieldDelegate: class {
    func moveToBookInfoViewController(VC: UIViewController)
}

class BookCollectionField: UIView {
    weak var delegate: BookCollectionFieldDelegate?
    var collectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
        .then {
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.55, height: 90)
            $0.scrollDirection = .horizontal
        }
    
    let spaceForLeftRight = (UIScreen.main.bounds.width * 0.75 - UIScreen.main.bounds.width * 0.55) / 2
    var currentIndex: CGFloat = 0
    var books: [SimpleBookItem] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        setupCollectionView()
    }
    
    func setBookItems(items: [SimpleBookItem]) {
        books = items
        collectionView.reloadData()
    }
    
    func moveToFirstPage() {
        if currentIndex > 0 {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
            currentIndex = 0
        }
    }
    
    func moveToNextPage() {
        if books.count <= 1 { return }
        if currentIndex == CGFloat(books.count-1) { return }
        collectionView.scrollToItem(at: IndexPath(row: Int(currentIndex) + 1, section: 0), at: .centeredHorizontally, animated: true)
        currentIndex += 1
    }
    
    func moveToPrePage() {
        if books.count <= 1 { return }
        if currentIndex == 0 { return }
        collectionView.scrollToItem(at: IndexPath(row: Int(currentIndex) - 1, section: 0), at: .centeredHorizontally, animated: true)
        currentIndex -= 1
    }

}

// MARK: +UI
extension BookCollectionField {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
            .then {
                $0.register(BookCollectionCell.self, forCellWithReuseIdentifier: BookCollectionCell.identifier)
                $0.backgroundColor = UIColor.white.withAlphaComponent(0)
                $0.contentInset.left = spaceForLeftRight
                $0.contentInset.right = spaceForLeftRight
                $0.showsHorizontalScrollIndicator = false
                $0.decelerationRate = .fast
            }
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

// MARK: +Delegate
extension BookCollectionField: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionCell.identifier, for: indexPath) as? BookCollectionCell else {
            print("BookCollectionField - 재사용큐에서 cell을 찾지 못했습니다.")
            return BookCollectionCell().then {
                $0.setBookInformation(item: books[indexPath.item])
            }
        }
        
        cell.setBookInformation(item: books[indexPath.item])
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        // targetContentOff을 이용하여 x좌표가 얼마나 이동했는지 확인
        // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        // scrollView, targetContentOffset의 좌표 값으로 스크롤 방향을 알 수 있다.
        // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
        // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }

        if currentIndex > roundedIndex && currentIndex != 0 {
            currentIndex -= 1
            roundedIndex = currentIndex
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = currentIndex
        }
        
        // 위 코드를 통해 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - spaceForLeftRight, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let nextVC = BookInfoViewController()
        nextVC.isbn = self.books[indexPath.item].isbn
        self.delegate?.moveToBookInfoViewController(VC: nextVC)
        return true
    }
}
