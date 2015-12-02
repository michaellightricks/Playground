//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// This class represents a wrapper for a Flickr city. Since the object returned from the \c
/// FlickrFetcher is in the form of a dictionary, it requires using a key to retrieve the contained
/// information. Hence, this class's purpose is to provide easy information retrieval, and is
/// basically a collection of properties.
@interface FlickrCity : NSObject

/// Initialize with the all properties.
- (instancetype)initWithName:(NSString *)name flickrId:(NSString *)flickrId
                     country:(NSString *)country province:(NSString *)province;

/// The name of the city.
@property (nonatomic, readonly) NSString *name;

/// An id given by flickr.
@property (nonatomic, readonly) NSString *flickrId;

/// The name of the province containing the city.
@property (nonatomic, readonly) NSString *province;

/// The name of country containing the city.
@property (nonatomic, readonly) NSString *country;

NS_ASSUME_NONNULL_END

@end
