//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "FlickrPlaces.h"

#import "FlickrFetcher.h"

@implementation FlickrPlaces

- (instancetype)initFlickrPlacesWithRawData:(NSArray *)rawPlaces {
  if (self = [super init]) {
    _places = [self parsePlaces:rawPlaces];
  }
  return self;
}

- (NSString *)countryNameForIndex:(NSInteger)index {
  FlickrCity *flickrCity = [[self citiesForCountryIndex:index] firstObject];
  return flickrCity.country;
}

- (NSArray<FlickrCity *> *)citiesForCountryIndex:(NSInteger)index {
  if (index <= [self.places count]) {
    return self.places[index];
  }
  return nil;
}

- (NSInteger)cityCountForCountryIndex:(NSInteger)index {
  return [[self citiesForCountryIndex:index] count];
}

- (NSInteger)countryCount {
  return [self.places count];
}

- (NSArray *)parsePlaces:(NSArray *)places {
  NSMutableArray<FlickrCity *> *parsedPlaces = [[NSMutableArray alloc] init];
  for (NSDictionary *place in places) {
    FlickrCity *flickrCity = [self flickrCityFromDictionary:place];
    if (flickrCity) {
      [parsedPlaces addObject:flickrCity];
    }
  }
  return [self groupPlacesByCountry:parsedPlaces];
}

- (NSArray *)groupPlacesByCountry:(NSMutableArray<FlickrCity *> *)places {
  int countryIndex = 0;
  NSMutableArray *placesGroupedByCountry = [[NSMutableArray alloc] init];
  NSArray *distinctCountries = [places valueForKeyPath:@"@distinctUnionOfObjects.country"];
  
  for (NSString *country in distinctCountries) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"country = %@", country];
    NSArray *citiesInSpecificCountry = [places filteredArrayUsingPredicate:predicate];
    placesGroupedByCountry[countryIndex] = citiesInSpecificCountry;
    countryIndex++;
  }
  return [placesGroupedByCountry copy];
}

- (FlickrCity *)flickrCityFromDictionary:(NSDictionary *)cityDictionary {
  NSString *cityId = cityDictionary[FLICKR_PLACE_ID];
  NSArray<NSString *> *cityProperties = [self cityPropertiesFromString:
                                         cityDictionary[FLICKR_PLACE_NAME]];
  if (cityProperties) {
    return [[FlickrCity alloc] initWithName:cityProperties[0]
                                   flickrId:cityId
                                    country:[cityProperties count] > 1 ? cityProperties[1] : @""
                                   province:[cityProperties count] > 2 ? cityProperties[2] : @""];
  }
  return nil;
}

- (NSArray<NSString *> *)cityPropertiesFromString:(NSString *)cityString {
  NSMutableArray<NSString *> *cityProperties = [[NSMutableArray alloc] init];
  NSRegularExpression* wordPattern = [NSRegularExpression regularExpressionWithPattern:@"\\w+"
                                                                               options:0
                                                                                 error:nil];
  NSArray *propertiesFound = [wordPattern matchesInString:cityString
                                                  options:0
                                                    range:NSMakeRange(0, [cityString length])];
  if (propertiesFound) {
    for (NSTextCheckingResult *property in propertiesFound) {
      [cityProperties addObject:[cityString substringWithRange:[property range]]];
    }
    return [cityProperties copy];
  }
  return nil;
}

@end
