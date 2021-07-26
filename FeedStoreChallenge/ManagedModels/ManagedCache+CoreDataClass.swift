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
final class ManagedCache: NSManagedObject {
	@nonobjc class func fetchRequest() -> NSFetchRequest<ManagedCache> {
		let request = NSFetchRequest<ManagedCache>(entityName: entity().name!)
		request.returnsObjectsAsFaults = false
		return request
	}

	@NSManaged var timestamp: Date
	@NSManaged var feedImages: NSOrderedSet

	convenience init(context: NSManagedObjectContext, feed: [LocalFeedImage], timestamp: Date) {
		self.init(context: context)
		self.timestamp = timestamp
		self.feedImages = NSOrderedSet(array: feed.map { localFeed in
			let managedFeedImage = ManagedFeedImage(context: context)
			managedFeedImage.id = localFeed.id
			managedFeedImage.imageDescription = localFeed.description
			managedFeedImage.location = localFeed.location
			managedFeedImage.url = localFeed.url
			return managedFeedImage
		})
	}

	func toModels() -> [LocalFeedImage] {
		return feedImages.compactMap { ($0 as? ManagedFeedImage) }
			.map { LocalFeedImage(
				id: $0.id,
				description: $0.imageDescription,
				location: $0.location,
				url: $0.url
			) }
	}
}
