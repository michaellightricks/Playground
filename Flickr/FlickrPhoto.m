//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "FlickrPhoto.h"

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FlickrPhoto

- (instancetype)initFlickrPhotoWithTitle:(nullable NSString *)title
                             description:(nullable NSString *)description
                                metaData:(NSDictionary *)metaData {
    if (self = [super init]) {
        _title = title ?: @"";
        _photoDescription = description ?:  @"";
        _metaData = metaData;
    }
    return self;
}

+ (NSArray<FlickrPhoto *> *)flickrPhotosFromDicionaryNSArray:(NSArray *) photoArray {
    NSMutableArray<FlickrPhoto *> *returnedArray = [[NSMutableArray alloc] init];
    for (NSDictionary *photo in photoArray) {
        [returnedArray addObject:
         [[FlickrPhoto alloc] initFlickrPhotoWithTitle:photo[FLICKR_PHOTO_TITLE]
                                           description:photo[FLICKR_PHOTO_DESCRIPTION]
                                              metaData:photo]
         ];
    }
    return returnedArray;
}

@end

NS_ASSUME_NONNULL_END
