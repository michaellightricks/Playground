//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "ImageViewController.h"

#import "FlickrFetcher.h"
#import "URLDownloadTask.h"

/// Maximum scale allowed.
static CGFloat const kMaxZoomScale = 2;

/// Minimum scale allowed.
static CGFloat const kMinZoomScale = 0.2;

@interface ImageViewController () <UIScrollViewDelegate>

/// Fills the whole screen, and holds the imageView.
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/// Subview of the scroll view, allows panning and zooming.
@property (strong, nonatomic) UIImageView *imageView;

/// Holds the viewed image.
@property (strong, nonatomic) UIImage *image;

/// The spinner rolls while the image is being fetched.
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.imageView = [[UIImageView alloc] init];
  [self.scrollView addSubview:self.imageView];
  [self fetchPhoto];
}

- (void)fetchPhoto {
  __weak ImageViewController *weakSelf = self;
  [self.spinner startAnimating];
  [URLDownloadTask downloadFromURL:[FlickrFetcher URLforPhoto:self.photoMetaData
                                                       format:FlickrPhotoFormatLarge]
                    withCompletion:^(NSData *photoData, NSError *error) {
                      if (!error) {
                        ImageViewController *strongSelf = weakSelf;
                        strongSelf.image = [UIImage imageWithData:photoData];
                        [strongSelf.spinner stopAnimating];
                      } else {
                        NSLog(@"Error while trying to fetch the photo: %@ %@", error,
                              [error userInfo]);
                      }
                    }];
}

- (UIImage *)image {
  return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
  self.imageView.image = image;
  [self.imageView sizeToFit];
  self.scrollView.contentSize = self.image.size;
}

#pragma mark -
#pragma mark Scroll and Zoom
#pragma mark -

- (void)setScrollView:(UIScrollView *)scrollView {
  _scrollView = scrollView;
  _scrollView.minimumZoomScale = kMinZoomScale;
  _scrollView.maximumZoomScale = kMaxZoomScale;
  _scrollView.delegate = self;
  _scrollView.contentSize = self.image.size;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

@end
