//
//  ManagedFeedImage+CoreDataClass.swift
//  FeedStoreChallenge
//
//  Created by Luis Zapata on 17-07-21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedFeedImage)
final class ManagedFeedImage: NSManagedObject {
	@nonobjc class func fetchRequest() -> NSFetchRequest<ManagedFeedImage> {
		return NSFetchRequest<ManagedFeedImage>(entityName: entity().name!)
	}

	@NSManaged var id: UUID
	@NSManaged var imageDescription: String?
	@NSManaged var location: String?
	@NSManaged var url: URL
	@NSManaged var cache: ManagedCache
}
