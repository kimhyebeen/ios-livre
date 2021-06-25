//
//  DetailViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import RxSwift
import RxCocoa

class SearchViewModel {
    let input = Input()
    let output = Output()
    private var editMode = false
    private var networkService: BaseNetworkService?
    private var persistenceService: BasePersistenceService?
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchWord = PublishSubject<String>()
        let searchButton = PublishSubject<Void>()
        let favoriteEditButton = PublishSubject<Void>()
    }
    
    struct Output {
        let executeToast = PublishRelay<String>()
        let booksResult = PublishRelay<[Book]>()
        let blogsResult = PublishRelay<[BlogItem]>()
        let recentSearchedText = RecentSearchConfig.shared.replayRelay
        let favoriteEditMode = BehaviorRelay<Bool>(value: false)
        let favoriteResult = PublishRelay<[FavoriteBook]>()
    }
    
    init(networkService: BaseNetworkService, persistenceService: BasePersistenceService) {
        self.networkService = networkService
        self.persistenceService = persistenceService
        
        input.searchButton.withLatestFrom(input.searchWord)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.requestBookItems(value: text)
                self?.output.recentSearchedText.accept(text)
            }).disposed(by: disposeBag)
        
        input.favoriteEditButton.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.editMode = !self.editMode
            self.output.favoriteEditMode.accept(self.editMode)
        }).disposed(by: disposeBag)
    }
    
    func requestBookItems(value: String) {
        func mappingToBook(_ data: BookResponse) -> Book { Book(title: data.title, image: data.image, author: data.author, price: data.priceString, isbn: data.isbn, description: data.description, publisher: data.publisher, publishDate: data.publishDate) }
        
        networkService?.books(query: value, start: 1, display: 10) { [weak self] response in
            self?.output.booksResult.accept(response.map { mappingToBook($0) })
        }
    }
    
    func requestBlogItems(value: String) {
        func mappingToBlogItem(_ data: BlogResponse) -> BlogItem { BlogItem(title: data.title, link: data.link, description: data.description, bloggername: data.bloggername, postDate: data.postDate) }
        
        networkService?.blogs(query: value, start: 1, display: 10) { [weak self] response in
            self?.output.blogsResult.accept(response.map { mappingToBlogItem($0)})
        }
    }
    
    func requestKeywordItems(value: String, handler: @escaping (String) -> ()) {
        networkService?.keywords(body: KeywordRequestBody(argument: KeywordRequestArgument(question: value)), handler)
    }
    
    func updatePoint(value: String) {
        RewardConfig.shared.addPoint(point: Float(value.count * 2))
    }
    
    func fetchFavorites() {
        print("Search ViewModel - 즐겨찾기 목록을 가져와요.")
        guard let result = persistenceService?.fetch(request: FavoriteBook.fetchRequest()) else { return }
        output.favoriteResult.accept(result)
    }
    
    func isExistInFavorite(_ title: String) -> Bool {
        guard let count = persistenceService?.fetchBookForTitle(title).count else { return false }
        return count > 0 ? true : false
    }
    
    func deleteForTitle(_ title: String) {
        guard let result = persistenceService?.deleteBookForTitle(title) else { return }
        if !result {
            output.executeToast.accept("🚫 즐겨찾기 삭제 실패")
            return
        }
        print("Search ViewModel - 타이틀로 즐겨찾기 삭제 성공")
        fetchFavorites()
    }
    
    func deleteBook(_ item: FavoriteBook) {
        guard let result = persistenceService?.delete(object: item) else { return }
        if !result {
            output.executeToast.accept("🚫 즐겨찾기 삭제 실패")
            return
        }
        print("Search ViewModel - 즐겨찾기 아이템 삭제 성공")
        fetchFavorites()
    }
    
    func insertFavorite(_ item: Book) {
        guard let result = persistenceService?.insertBook(item) else { return }
        if !result {
            output.executeToast.accept("🚫 즐겨찾기에 등록 실패")
            return
        }
        print("Search ViewModel - 즐겨찾기 추가 성공")
        fetchFavorites()
    }
}
