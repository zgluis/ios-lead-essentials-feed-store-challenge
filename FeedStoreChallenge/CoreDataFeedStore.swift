//
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
	private static let modelName = "FeedStore"
	private static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

	struct ModelNotFound: Error {
		let modelName: String
	}

	public init(storeURL: URL) throws {
		guard let model = CoreDataFeedStore.model else {
			throw ModelNotFound(modelName: CoreDataFeedStore.modelName)
		}

		container = try NSPersistentContainer.load(
			name: CoreDataFeedStore.modelName,
			model: model,
			url: storeURL
		)
		context = container.newBackgroundContext()
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		context.perform {
			let fetchRequest: NSFetchRequest = ManagedCache.fetchRequest()
			do {
				let result = try self.context.fetch(fetchRequest)
				if let managedCache = result.first,
				   managedCache.feedImage.count > .zero {
					completion(.found(feed: managedCache.toModels(), timestamp: managedCache.timestamp))
				} else {
					completion(.empty)
				}
			} catch {
				completion(.failure(error))
			}
		}
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let context = context
		context.perform {
			let fetchRequest: NSFetchRequest = ManagedCache.fetchRequest()
			do {
				let result = try self.context.fetch(fetchRequest)
				result.first.map(context.delete)

				let _ = ManagedCache(context: context, feed: feed, timestamp: timestamp)
				try self.context.save()
				completion(nil)
			} catch {}
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		fatalError("Must be implemented")
	}
}
