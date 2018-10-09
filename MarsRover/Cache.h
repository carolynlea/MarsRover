//
//  Cache.h
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cache : NSObject

@property (nonatomic, readonly) NSDictionary *cache;
@property (nonatomic, readonly) NSString *queueString;

-(NSDictionary *)cache;
-(void)value;
-(void)clear;

@end

NS_ASSUME_NONNULL_END
