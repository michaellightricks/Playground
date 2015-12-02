//
//  Copyright (c) 2015 Lightricks. All rights reserved.
//  Created by Ophir on 9/25/15.
//

#import "FlickrCity.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FlickrCity
- (instancetype)initWithName:(NSString *)name flickrId:(NSString *)flickrId
                     country:(NSString *)country province:(NSString *)province {
  if (self = [super init]) {
    _name = name;
    _flickrId = flickrId;
    _country = country;
    _province = province;
  }
  return self;
}
@end

NS_ASSUME_NONNULL_END
