//
//  RequestFavoriteBook.swift
//  livre
//
//  Created by 김혜빈 on 2021/04/03.
//

import UIKit
import CoreData

class PersistenceManager {
    
    static var shared: PersistenceManager = PersistenceManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorite") // Favorite.xcdatamodeld의 PersistentContainer를 가져와요.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        } )
        
        return container
    }()
    
    private var context: NSManagedObjectContext { self.persistentContainer.viewContext }
    private var entity: NSEntityDescription { NSEntityDescription.entity(forEntityName: "FavoriteBook", in: self.context)! }
    
    func insertBook(_ item: Book) -> Bool {
        let book = NSManagedObject(entity: entity, insertInto: context)
        book.setValue(item.titleString, forKey: "title")
        book.setValue(item.image, forKey: "image")
        book.setValue(item.authorString, forKey: "author")
        book.setValue(item.contentsString, forKey: "contents")
        book.setValue(item.publishDateString, forKey: "published")
        
        do {
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        guard let result = try? self.context.fetch(request) else { return [] }
        
        return result
    }
    
    func fetchBookForTitle(_ title: String) -> [FavoriteBook] {
        let predicate = NSPredicate(format: "title == %@", title)
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "FavoriteBook")
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request) as! [FavoriteBook]
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    func deleteBookForTitle(_ title: String) -> Bool {
        let result = fetchBookForTitle(title)
        result.forEach { delete(object: $0) }
        return result.count > 0 ? true : false
    }
    
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let delete = NSBatchDeleteRequest(fetchRequest: T.fetchRequest())
        do {
            try self.context.execute(delete)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            print(error.localizedDescription)
            return -1
        }
    }
}
