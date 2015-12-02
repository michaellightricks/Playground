//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "LatestUserPhotosVC.h"

#import "FlickrPhoto.h"
#import "PhotosCache.h"

@implementation LatestUserPhotosVC

- (void)viewWillAppear:(BOOL)animated {
  self.photos = [FlickrPhoto flickrPhotosFromDicionaryNSArray:[PhotosCache photos]];
  [self.tableView reloadData];
}

@end
