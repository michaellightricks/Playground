//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <UIKit/UIKit.h>

#import "FlickrPhoto.h"

NS_ASSUME_NONNULL_BEGIN

/// This class shows a list of Flickr photo objects. To use this class, set the \c photos property.
/// The photos are shown in the same order as in the array.
@interface PhotosListTableVC : UITableViewController

/// Contains the list of available photos.
@property (nonatomic,strong) NSArray<FlickrPhoto *> *photos;

@end

NS_ASSUME_NONNULL_END
