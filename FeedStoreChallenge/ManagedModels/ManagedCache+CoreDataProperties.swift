//
//  ManagedCache+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Luis Zapata on 17-07-21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

extension ManagedCache {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCache> {
		return NSFetchRequest<ManagedCache>(entityName: "ManagedCache")
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
