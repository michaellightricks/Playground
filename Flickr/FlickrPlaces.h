//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <Foundation/Foundation.h>

#import "FlickrCity.h"

/// This class serves as wrapper for the the \c NSArray of places received from Flickr.
/// The raw data form can be seen in the Flickr api.
///
/// @sa Flickr api: https://www.flickr.com/services/api/flickr.places.getTopPlacesList.html
@interface FlickrPlaces : NSObject

/// Receives an \c NSArray containing raw data from the \c FlickFetcher, parses it and saves the
/// results in the \c places property. For more information about the parsing process, see \c
/// places.
///
/// @sa Flickr api: https://www.flickr.com/services/api/flickr.places.getTopPlacesList.html
- (instancetype)initFlickrPlacesWithRawData:(NSArray *)rawPlaces;

/// Returns an \c NSArray containing the cities for a country index, or \c nil if \c index is out
/// of bounds.
- (NSArray<FlickrCity *> *)citiesForCountryIndex:(NSInteger)index;

/// Returns the number of cities for a given country index, or \c nil if \c index is out of bounds.
- (NSInteger)cityCountForCountryIndex:(NSInteger)index;

/// Returns the number of countries in the list.
- (NSInteger)countryCount;

/// Returns the name of the country at \c index, or \c nil if \c index is out of bounds.
- (NSString *)countryNameForIndex:(NSInteger)index;

/// Contains a parsed version of \c rawPlaces: an \c NSArray where each cell represents a country
/// and contains an \c NSArray<FlickrCity *> containing the cities in it.
@property (nonatomic, readonly) NSArray *places;

@end
