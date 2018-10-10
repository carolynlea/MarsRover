//
//  SolDescription.h
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Camera.h"

NS_ASSUME_NONNULL_BEGIN

@interface SolDescription : NSObject

@property (nonatomic) int sol;
@property (nonatomic) int totalPhotos;
@property (nonatomic) NSArray<NSString *> *cameras;

-(instancetype)initWithSol:(int)sol totalPhotos:(int)totalPhotos cameras:(NSArray<NSString *> *)cameras;

-(nullable instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
