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

	@NSManaged public var timeStamp: Date?
	@NSManaged public var feedImage: NSOrderedSet?
}

// MARK: Generated accessors for feedImage
extension ManagedCache {
	@objc(insertObject:inFeedImageAtIndex:)
	@NSManaged public func insertIntoFeedImage(_ value: ManagedFeedImage, at idx: Int)

	@objc(removeObjectFromFeedImageAtIndex:)
	@NSManaged public func removeFromFeedImage(at idx: Int)

	@objc(insertFeedImage:atIndexes:)
	@NSManaged public func insertIntoFeedImage(_ values: [ManagedFeedImage], at indexes: NSIndexSet)

	@objc(removeFeedImageAtIndexes:)
	@NSManaged public func removeFromFeedImage(at indexes: NSIndexSet)

	@objc(replaceObjectInFeedImageAtIndex:withObject:)
	@NSManaged public func replaceFeedImage(at idx: Int, with value: ManagedFeedImage)

	@objc(replaceFeedImageAtIndexes:withFeedImage:)
	@NSManaged public func replaceFeedImage(at indexes: NSIndexSet, with values: [ManagedFeedImage])

	@objc(addFeedImageObject:)
	@NSManaged public func addToFeedImage(_ value: ManagedFeedImage)

	@objc(removeFeedImageObject:)
	@NSManaged public func removeFromFeedImage(_ value: ManagedFeedImage)

	@objc(addFeedImage:)
	@NSManaged public func addToFeedImage(_ values: NSOrderedSet)

	@objc(removeFeedImage:)
	@NSManaged public func removeFromFeedImage(_ values: NSOrderedSet)
}

extension ManagedCache: Identifiable {}
