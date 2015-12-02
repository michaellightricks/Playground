//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import <Foundation/Foundation.h>

/// This class performs asynchronous fetching from urls.
@interface URLDownloadTask : NSObject

/// Used as a completion handler after the download task has finished in \c downloadFromURL.
typedef void (^URLDownloadTaskCompletion)(NSData *, NSError *);

/// The method creates a request and session using the provided \c NSURL, and calls the completion
/// block provided as follows: in case of an error, \c NSData is set to nil, and \c NSError
/// contains the received error. Otherwise, \c NSData contains the received data, and \c NSError
/// is set to nil.
+ (void)downloadFromURL:(NSURL *)url withCompletion:(URLDownloadTaskCompletion)complete;

@end

