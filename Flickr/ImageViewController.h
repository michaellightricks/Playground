//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <UIKit/UIKit.h>

/// A UIViewController which displays a photo, and allows zooming and panning. To use this class
/// you must set the \c photoMetaData property.
@interface ImageViewController : UIViewController

/// Contains the meta-data needed for the \c FlickrFetcher to be able to fetch the photo.
/// This meta-data is received from the \c FlickrFetcher when requesting for photos.
///
/// @sa For information regarding the requests, responses and examples of meta-data, see
/// https://www.flickr.com/services/api/flickr.photos.search.html.
@property (nonatomic, copy) NSDictionary *photoMetaData;

@end
