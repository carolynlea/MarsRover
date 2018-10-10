//
//  MarsPhoto.m
//  MarsRover
//
//  Created by Carolyn Lea on 10/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "MarsPhoto.h"

@implementation MarsPhoto

- (instancetype)initWithIdentifier:(NSNumber *)identifier
                               sol:(NSNumber *)sol
                            camera:(Camera *)camera
                         earthDate:(NSDate *)earthDate
                          imageURL:(NSURL *)imageURL
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSNumber *identifier = dictionary[@"id"];
    NSNumber *sol = dictionary[@"sol"];
    Camera *camera = dictionary[@"camera"];
    NSDate *earthDate = dictionary[@"earth_date"];
    NSURL *imageURL = dictionary[@"img_src"];
    
    if (!identifier || !sol || !camera || !earthDate || !imageURL)
    {
        return nil;
    }
    
    return [self initWithIdentifier:identifier sol:sol camera:camera earthDate:earthDate imageURL:imageURL];
}

@end
