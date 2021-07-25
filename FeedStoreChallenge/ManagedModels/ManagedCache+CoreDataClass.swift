//
//  ManagedCache+CoreDataClass.swift
//  FeedStoreChallenge
//
//  Created by Luis Zapata on 17-07-21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedCache)
public class ManagedCache: NSManagedObject {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCache> {
		let request = NSFetchRequest<ManagedCache>(entityName: entity().name!)
		request.returnsObjectsAsFaults = false
		return request
	}

	@NSManaged public var timestamp: Date
	@NSManaged public var feedImage: NSOrderedSet

	convenience init(context: NSManagedObjectContext, feed: [LocalFeedImage], timestamp: Date) {
		self.init(context: context)
		self.feedImage = NSOrderedSet(array: feed.map { localFeed in
			self.timestamp = timestamp
			let managedFeedImage = ManagedFeedImage(context: context)
			managedFeedImage.id = localFeed.id
			managedFeedImage.imageDescription = localFeed.description
			managedFeedImage.location = localFeed.location
			managedFeedImage.url = localFeed.url
			return managedFeedImage
		})
	}

	func toModels() -> [LocalFeedImage] {
		return feedImage.compactMap { ($0 as? ManagedFeedImage) }
			.map { LocalFeedImage(
				id: $0.id,
				description: $0.imageDescription,
				location: $0.location,
				url: $0.url
			) }
	}
}
