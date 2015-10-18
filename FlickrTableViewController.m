//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "FlickrTableViewController.h"

#import "FlickrCity.h"
#import "FlickrFetcher.h"
#import "PhotoListTableForCityIdVC.h"

@interface FlickrTableViewController()

/// \c FlickrPlaces object which contains all the cities in the list.
@property (nonatomic, readwrite) FlickrPlaces *places;

@end

@implementation FlickrTableViewController

-(void)setPlacesFromRawData:(NSArray *)places {
    self.places = [[FlickrPlaces alloc] initFlickrPlacesWithRawData:places];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.places countryCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.places cityCountForCountryIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Flickr Place Cell"
                                                            forIndexPath:indexPath];
    FlickrCity *flickrCity = [self.places citiesForCountryIndex:indexPath.section][indexPath.row];
    cell.textLabel.text = flickrCity.name;
    cell.detailTextLabel.text = flickrCity.province;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.places countryNameForIndex:section] ?: @"Unknown Country";
}

#pragma mark -
#pragma mark Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    FlickrCity *flickrCity = [self.places citiesForCountryIndex:indexPath.section][indexPath.row];
    NSString *city = flickrCity.name;
    NSString *cityId  = flickrCity.flickrId;
    
    PhotoListTableForCityIdVC *photoListViewController =
    (PhotoListTableForCityIdVC *)segue.destinationViewController;
  
    photoListViewController.cityName = city;
    photoListViewController.cityId = cityId;
}

@end
