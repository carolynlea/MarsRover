//
//  FetchImageOperation.m
//  MarsRover
//
//  Created by Carolyn Lea on 10/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "FetchImageOperation.h"
@interface FetchImageOperation()
@property (atomic, readwrite, getter=isExecuting)BOOL executing;
@property (atomic, readwrite, getter=isFinished)BOOL finished;
@end
@implementation FetchImageOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

-(void)start
{
    self.executing = YES;
    //self.executing = NO;
    //self.finished = YES;
}


@end
