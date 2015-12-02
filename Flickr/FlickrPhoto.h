//
//  Created by ophir abitbol on 10/26/15.
//  Copyright © 2015 Ophir. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// This class represents a wrapper for a Flickr photo, and allows easy information retrieval:
/// Title, description and meta-data for the image retrieval.
/// Notice that not all flickr Photos contain a description, or even a title.
@interface FlickrPhoto : NSObject

/// Initializes with the given parameters.
- (instancetype)initFlickrPhotoWithTitle:(nullable NSString *)title
                             description:(nullable NSString *)description
                                metaData:(NSDictionary *)metaData;

/// The photo title.
@property (readonly, nonatomic) NSString *title;

/// A description of the photo.
@property (readonly, nonatomic) NSString *photoDescription;

/// The meta-data for the photo retrieval.
@property (readonly, nonatomic) NSDictionary *metaData;

/// This method receives an array of flickr photo dictionaries as they are received from the flickr
/// API, and parses them into a \c FlickrPhoto.
///
/// @sa Flickr API: https://www.flickr.com/services/api/
+ (NSArray<FlickrPhoto *> *)flickrPhotosFromDicionaryNSArray:(NSArray *)photoArray;

NS_ASSUME_NONNULL_END

@end
