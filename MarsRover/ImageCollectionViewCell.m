//
//  ImageCollectionViewCell.m
//  MarsRover
//
//  Created by Carolyn Lea on 10/9/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

-(void)prepareForReuse
{
    [super prepareForReuse];
    _imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
