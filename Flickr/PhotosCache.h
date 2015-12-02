//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <Foundation/Foundation.h>

#import "FlickrPhoto.h"

/// This class handles the caching of the user's recently viewed photos.
/// Notice that the actual photo isn't saved, but rather the meta-data needed to retrieve the
/// photo.
@interface PhotosCache : NSObject

/// Add a Flickr photo object's meta-data to the cache. There are no duplicates in the cache,
/// adding a photo which already exists in the cache will simply move it to the head of the list.
/// The photos are ordered by FILO.
+ (void)addPhoto:(FlickrPhoto *)flickrPhoto;

/// Get the list of photos stored on the cache.
+ (NSArray *)photos;

/// Set the maximum num of photos in the cache.
+ (void)setMaxPhotos:(NSUInteger)maxPhotos;

/// Get the maximum num of photos in the cache.
+ (NSUInteger)maxPhotos;

@end
