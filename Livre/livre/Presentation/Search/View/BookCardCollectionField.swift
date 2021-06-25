//
//  BookCardCollectionField.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/28.
//

import UIKit

//protocol BookCardCollectionFieldDelegate: class {
//    func requestMoreBooks()
//}

class BookCardCollectionField: UIView {
//    weak var delegate: BookCardCollectionFieldDelegate?
    weak var bookcardDelegate: BookCardCellDelegate?
    var collectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    let cellWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    let spaceForLeftRight = UIScreen.main.bounds.width * 0.1
    var currentIndex: CGFloat = 0
    var books: [Book] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        setupCollectionView()
    }
    
    func setBookItems(items: [Book]) {
        books = items
        collectionView.reloadData()
    }
    
    func addBookItems(items: [Book]) {
        books.append(contentsOf: items)
        collectionView.reloadData()
    }
    
    func moveToFirstPage() {
        if currentIndex == 0 { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.currentIndex = 0
        }
    }
    
    func moveToNextPage() {
        if books.count <= 1 { return }
        if currentIndex == CGFloat(books.count-1) {
//            delegate?.requestMoreBooks()
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.scrollToItem(at: IndexPath(row: Int(self.currentIndex) + 1, section: 0), at: .centeredHorizontally, animated: true)
            self.currentIndex += 1
        }
    }
    
    func moveToPrePage() {
        if books.count <= 1 || currentIndex == 0 { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.scrollToItem(at: IndexPath(row: Int(self.currentIndex) - 1, section: 0), at: .centeredHorizontally, animated: true)
            self.currentIndex -= 1
        }
    }

}

extension BookCardCollectionField {
    private func setupCollectionView() {
        setupFlowLayoutProperties()
        setupCollectionViewProperties()
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupFlowLayoutProperties() {
        flowLayout.itemSize = CGSize(width: cellWidth, height: self.frame.height - 30)
        flowLayout.scrollDirection = .horizontal
    }
    
    private func setupCollectionViewProperties() {
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.register(BookCardCell.self, forCellWithReuseIdentifier: BookCardCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.contentInset.left = spaceForLeftRight
        collectionView.contentInset.right = spaceForLeftRight
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension BookCardCollectionField: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { books.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCardCell.identifier, for: indexPath) as? BookCardCell else {
            print("BookCardCollectionField - 재사용큐에서 cell을 찾지 못했습니다.")
            return BookCardCell()
        }
        cell.delegate = bookcardDelegate
        cell.setBookInformation(item: books[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let isbn = books[indexPath.item].isbn.split(separator: " ").map { String($0) }[1]
        guard let url = URL(string: "http://bsearch.interpark.com/dsearch/book.jsp?sch=all&query=\(isbn)") else { return true }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("BookCardCollectionField - 인터파크 도서 검색 url에 연결하지 못했습니다.")
        }
        return true
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
        
        // index를 반올림하여 사용하면 item의 절반 사이즈만큼 스크롤을 해야 페이징이 된다.
        // 스크로로 방향을 체크하여 올림,내림을 사용하면 좀 더 자연스러운 페이징 효과를 낼 수 있다.
        let touchInX = targetContentOffset.pointee.x
        let touchOutX = scrollView.contentOffset.x
        if touchInX < touchOutX { roundedIndex = floor(index) }
        else if touchInX > touchOutX { roundedIndex = ceil(index) }
        else { roundedIndex = round(index) }
        
        if currentIndex > roundedIndex && currentIndex != 0 {
            currentIndex -= 1
            roundedIndex = currentIndex
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = currentIndex
        }
        
        // 위 코드를 통해 얻은 페이징 될 좌표값을 targetContentOffset에 대입하면 된다.
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - spaceForLeftRight, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
