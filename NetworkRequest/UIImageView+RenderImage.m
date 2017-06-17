//
//  UIImageView+RenderImage.m
//  NetworkRequest
//
//  Created by Ragaie Alfy on 6/16/17.
//  Copyright © 2017 Ragaie Alfy. All rights reserved.
//

#import "UIImageView+RenderImage.h"

@implementation UIImageView (RenderImage)
-(void)setImageWithURL:(NSString *)urlString{
    
    UIActivityIndicatorView *indecator = [[UIActivityIndicatorView alloc]initWithFrame: CGRectMake([self frame].origin.x + ( [self frame].size.width / 2 ), [self frame].origin.y + ([self frame].size.height / 2), 20, 20)];
    
    [indecator setColor: [UIColor blueColor]];
    [indecator startAnimating];
    [self addSubview:indecator];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:urlString];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       
                       //This is your completion handler
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           self.image = [UIImage imageWithData:imageData];
                           self.image = self.image;
                           [indecator stopAnimating];
                       });
                   });
    
}
@end
