//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "PhotoListTableForCityIdVC.h"

#import "FlickrFetcher.h"
#import "FlickrPhoto.h"
#import "URLDownloadTask.h"

NS_ASSUME_NONNULL_BEGIN

/// Sets the maximum number of results for the \c FlickrFetcher. This will define the maximum number
/// of cities in the list.
static NSUInteger const kMaxResults = 50;

@interface PhotoListTableForCityIdVC ()

/// The refresh controll spins while the photos are being fetched.
@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;

@end

@implementation PhotoListTableForCityIdVC

- (void)setCityName:(NSString *)cityName {
  _cityName = cityName;
  self.title = [NSString stringWithFormat:@"Top %lu Photos - %@", kMaxResults, cityName];
}

- (void)startDownloadingPhotos {
  __weak PhotoListTableForCityIdVC *weakSelf = self;
  [self.refresh beginRefreshing];
  [self.tableView setContentOffset:CGPointMake(0,
                                               self.tableView.contentOffset.y -
                                               self.refreshControl.frame.size.height) animated:YES];
  [URLDownloadTask downloadFromURL:[FlickrFetcher URLforPhotosInPlace:self.cityId
                                                           maxResults:kMaxResults]
                    withCompletion:^(NSData *photoData, NSError *error) {
                      if (!error) {
                        NSDictionary *photoDictionary = [NSJSONSerialization
                                                         JSONObjectWithData:photoData options:0
                                                         error:NULL];
                        PhotoListTableForCityIdVC *strongSelf = weakSelf;
                        strongSelf.photos = [self parsePhotos:[photoDictionary valueForKeyPath:
                                                             FLICKR_RESULTS_PHOTOS]];
                        [strongSelf.refresh endRefreshing];
                        [strongSelf.tableView reloadData];
                      } else {
                        NSLog(@"Error while trying to fetch photos: %@ %@", error,
                              [error userInfo]);
                      }
                    }];
}

- (IBAction)refreshTable:(id)sender {
  [self startDownloadingPhotos];
}

- (void)viewDidLoad {
  [self startDownloadingPhotos];
}

- (NSArray <FlickrPhoto *>*)parsePhotos:(NSArray *)photos {
  NSMutableArray <FlickrPhoto *> *parsedPhotos = [[NSMutableArray alloc] init];
  for (NSDictionary *photo in photos) {
    [parsedPhotos addObject:[[FlickrPhoto alloc]
                             initFlickrPhotoWithTitle:photo[FLICKR_PHOTO_TITLE]
                                          description:photo[FLICKR_PHOTO_DESCRIPTION]
                                             metaData:photo]];
  }
  return parsedPhotos;
}
@end

NS_ASSUME_NONNULL_END
