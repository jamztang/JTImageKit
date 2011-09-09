//
//  UIImage+JTImageCrop.h
//  JTImage
//
//  Created by james on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JTImageCrop)

+ (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect;
+ (UIImage *)imageWithImage:(UIImage *)image cropInRelativeRect:(CGRect)rect;   // CGRect(0...1, 0...1, 0...1, 0...1)
+ (UIImage *)imageWithImage:(UIImage *)image cropInRatio:(CGSize)ratio;

@end

CGSize     CGSizeConstrainedInRatio(CGSize originalSize, CGSize ratio);
CGRect     CGRectTransformToRect(CGRect fromRect, CGRect toRect);
CGImageRef CGImageCreateWithImageInRelativeRect(CGImageRef image, CGRect rect);
CGImageRef CGImageCreateWithImageInRelativeRectWithRatio(CGImageRef image, CGRect rect, CGSize ratio);