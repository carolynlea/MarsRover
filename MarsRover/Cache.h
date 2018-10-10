//
//  Cache.h
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cache<Key, Value> : NSObject

-(instancetype)init;

-(void)cacheWithValue:(Value)value key:(Key)key;
-(Value)valueWithKey:(Key)key;
-(void)clear;

@end

NS_ASSUME_NONNULL_END
