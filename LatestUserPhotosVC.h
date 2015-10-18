//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <UIKit/UIKit.h>

#import "PhotosListTableVC.h"

/// This class shows a list of the user's recently viewed photos. Every Time a photo is viewed in
/// the app, it is added to the cache, and is ordered by LIFO. There are no duplicates in the list,
/// and viewing a photo from the list will simply change it's location in it, and place it in the
/// top.
@interface LatestUserPhotosVC : PhotosListTableVC

@end
