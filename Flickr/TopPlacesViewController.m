//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "TopPlacesViewController.h"

#import "FlickrFetcher.h"
#import "URLDownloadTask.h"

@interface TopPlacesViewController ()

/// The refresh control spins while the list of top places is being fetched.
@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;

@end

@implementation TopPlacesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self fetchPlaces];
}

- (IBAction)refreshTable:(id)sender {
  [self fetchPlaces];
}

-(void)fetchPlaces{
  __weak TopPlacesViewController *weakSelf = self;
  
  [self.refresh beginRefreshing];
  [URLDownloadTask downloadFromURL:[FlickrFetcher URLforTopPlaces]
                    withCompletion:^(NSData *placeData, NSError *error) {
                      if (!error) {
                        TopPlacesViewController *strongSelf = weakSelf;
                        
                        NSDictionary *placesArray = [NSJSONSerialization
                                                     JSONObjectWithData:placeData
                                                     options:0 error:NULL];
                        NSArray *rawPlaces = [placesArray
                                              valueForKeyPath: FLICKR_RESULTS_PLACES];
                        [strongSelf setPlacesFromRawData:rawPlaces];
                        [strongSelf.refresh endRefreshing];
                        [strongSelf.tableView reloadData];
                      } else {
                        NSLog(@"Error while trying to fetch top places: %@ %@", error,
                              [error userInfo]);
                      }
                    }];
}

@end
