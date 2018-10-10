//
//  MarsPhoto.h
//  MarsRover
//
//  Created by Carolyn Lea on 10/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Camera;

NS_ASSUME_NONNULL_BEGIN

@interface MarsPhoto : NSObject

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSNumber *sol;
@property (nonatomic, copy, readonly) Camera *camera;
@property (nonatomic, copy, readonly) NSDate *earthDate;
@property (nonatomic, copy, readonly) NSURL *imageURL;

- (instancetype)initWithIdentifier:(NSNumber *)identifier
                               sol:(NSNumber *)sol
                            camera:(Camera *)camera
                         earthDate:(NSDate *)earthDate
                          imageURL:(NSURL *)imageURL;

- (nullable instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
