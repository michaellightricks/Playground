//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "FlickrTableViewController.h"

/// This class shows a list of the "Top Places", which are fetched via the \c FlickrFetcher class.
/// The top places are arranged by country, and within each country the cities are arranged
/// alphabetically.
///
/// @sa Flickr api: https://www.flickr.com/services/api/flickr.places.getTopPlacesList.html
@interface TopPlacesViewController : FlickrTableViewController

@end
