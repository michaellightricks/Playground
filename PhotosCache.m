//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "PhotosCache.h"

/// Used to retrieve the cache from the \c NSUserDefaults.
static NSString * const kUserPhotosKey = @"userPhotos";

/// The maximum number of photos stored in the cache.
static NSUInteger maxSavedPhotos = 20;

@implementation PhotosCache

+ (void)addPhoto:(FlickrPhoto *)flickrPhoto {
  NSMutableArray *photosArrayFromCache  = [[self readCacheForKey:kUserPhotosKey] mutableCopy];
  if (photosArrayFromCache) {
    [self addPhotoToExistingCachedArray:flickrPhoto Array:photosArrayFromCache];
  } else {
    [self addPhotoToNewCachedArray:flickrPhoto];
  }
}

+ (void)addPhotoToExistingCachedArray:(FlickrPhoto *)flickrPhoto
                                Array:(NSMutableArray *)photoCache {
  [photoCache insertObject:flickrPhoto.metaData atIndex:0];
  [self eraseFirstItemDuplicatesFromArray:photoCache];
  [self writeToCache:[self clipArray:photoCache atIndex:maxSavedPhotos] forKey:kUserPhotosKey];
}

+ (void)addPhotoToNewCachedArray:(FlickrPhoto *)flickrPhoto {
  NSArray *photoCache = @[flickrPhoto.metaData];
  [self writeToCache:photoCache forKey:kUserPhotosKey];
}

+ (void)eraseFirstItemDuplicatesFromArray:(NSMutableArray *)array {
  [array removeObject:array[0] inRange:NSMakeRange(1, [array count] - 1)];
}

+ (NSArray *)clipArray:(NSArray *)array atIndex:(NSUInteger)clipIndex {
  if (clipIndex < [array count]) {
    return [array subarrayWithRange:NSMakeRange(1, clipIndex)];
  }
  return array;
}

#pragma mark -
#pragma mark Cache read / write
#pragma mark -

+ (id)readCacheForKey:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] objectForKey:kUserPhotosKey];
}

+ (void)writeToCache:(NSArray *)data forKey:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

#pragma mark -
#pragma mark Getters / Setters
#pragma mark -

+ (NSArray *)photos {
  return [self readCacheForKey:kUserPhotosKey];
}

+ (NSUInteger)maxPhotos {
  return maxSavedPhotos;
}

+ (void)setMaxPhotos:(NSUInteger)maxPhotos {
  maxSavedPhotos = maxPhotos;
}

@end
