//
//  SolDescription.m
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "SolDescription.h"

@implementation SolDescription

-(instancetype)initWithSol:(int)sol totalPhotos:(int)totalPhotos cameras:(NSArray *)cameras
{
    self = [super init];
    if(self)
    {
        _sol = sol;
        _totalPhotos = totalPhotos;
        _cameras = cameras;
    }
    return self;
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *solString = dictionary[@"sol"];
    int sol = [solString intValue];
    NSString *totalPhotosString = dictionary[@"totalPhotos"];
    int totalPhotos = [totalPhotosString intValue];
    NSArray *cameras = dictionary[@"cameras"];
    
    if(!sol || ! totalPhotos || !cameras)
    {
        return nil;
    }
    return [self initWithSol:sol totalPhotos:totalPhotos cameras: cameras];
}

@end
