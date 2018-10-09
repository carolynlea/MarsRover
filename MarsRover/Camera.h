//
//  Camera.h
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic) int identifier;
@property (nonatomic) NSString *name;
@property (nonatomic) int roverId;
@property (nonatomic) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
