//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "URLDownloadTask.h"

@implementation URLDownloadTask

+ (void)downloadFromURL:(NSURL *)url withCompletion:(URLDownloadTaskCompletion)complete {
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration
                                              ephemeralSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDownloadTask *task =
  [session downloadTaskWithRequest: request
                 completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                   NSData *dataFromFlickrJson =
                       error ? nil : [NSData dataWithContentsOfURL:localFile];
                   dispatch_async(dispatch_get_main_queue(), ^{
                     complete(dataFromFlickrJson, error);
                   });
                 }];
  [task resume];
}

@end
