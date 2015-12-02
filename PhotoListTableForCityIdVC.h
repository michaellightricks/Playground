//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "PhotosListTableVC.h"

NS_ASSUME_NONNULL_BEGIN

/// This class displays a list of photos for a specific \c Flickr cityID.
/// The \c cityID is used to fetch a list of the top photos from that city via \c FlickrFetcher.
/// Notice that \c PhotoListTableForCityIdVC doesn't receive the actual list, but just a cityID,
/// and fetches the list internally.
///
/// @sa For information regarding the cityID photo list request see
/// https://www.flickr.com/services/api/flickr.photos.search.html.
@interface PhotoListTableForCityIdVC : PhotosListTableVC

/// Contains the cityId received from the \c FlickrFetcher class.
/// the cityId is later used to retrieve photos from the \c FlickrFetcher for this city.
@property (strong, nonatomic) NSString *cityId;

/// Contains the city's name. The view's title uses this property. 
@property (strong, nonatomic) NSString *cityName;

@end

NS_ASSUME_NONNULL_END
