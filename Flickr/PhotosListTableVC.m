//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "PhotosListTableVC.h"

#import "FlickrFetcher.h"
#import "ImageViewController.h"
#import "PhotosCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosListTableVC ()

/// The refresh control spins while the photos are being fetched.
@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;

@end

@implementation PhotosListTableVC

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Flickr Photo"
                                                          forIndexPath:indexPath];
  // Cell name goes as follows: photo title, if exists, o.w. photo description, if exists, o.w.
  // empty.
  FlickrPhoto *flickrPhoto = [self.photos objectAtIndex:indexPath.row];
  if (flickrPhoto.title && [flickrPhoto.title length] > 0) {
    cell.textLabel.text = flickrPhoto.title;
    cell.detailTextLabel.text = flickrPhoto.photoDescription;
  } else if (flickrPhoto.photoDescription && [flickrPhoto.photoDescription length] > 0) {
    cell.textLabel.text = flickrPhoto.photoDescription;
  } else {
    cell.textLabel.text = @"";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([self.splitViewController.viewControllers count] > 1) {
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]]) {
      detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    if ([detail isKindOfClass:[ImageViewController class]]) {
      [self prepareImageViewController:detail forIndexPath:indexPath];
    }
  }
}

#pragma mark -
#pragma mark Navigation
#pragma mark -

- (void)prepareImageViewController:(ImageViewController *)imageViewController
                     forIndexPath:(NSIndexPath *)indexPath {
  FlickrPhoto *flickrPhoto = [self.photos objectAtIndex:indexPath.row];
  [PhotosCache addPhoto:flickrPhoto];
  imageViewController.title = flickrPhoto.title;
  imageViewController.photoMetaData = flickrPhoto.metaData;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
  [self prepareImageViewController:segue.destinationViewController forIndexPath:indexPath];
}

@end

NS_ASSUME_NONNULL_END
