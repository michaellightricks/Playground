//
// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Ophir on 9/25/15.
//

#import "FlickrPlaces.h"

#import <UIKit/UIKit.h>

/// View controller containing a generic list of places retrieved from Flickr.
@interface FlickrTableViewController : UITableViewController

/// \c FlickrPlaces object which contains all the cities in the list.
@property (nonatomic, readonly) FlickrPlaces *places;

/// Sets the list of \c places. Receives raw data in the form of an \c NSArray, which contains data
/// according to the Flickr API:
/// https://www.flickr.com/services/api/flickr.places.getTopPlacesList.html
/// The raw data is parsed and is stored according to the \c places format.
-(void)setPlacesFromRawData:(NSArray *)places;

@end
