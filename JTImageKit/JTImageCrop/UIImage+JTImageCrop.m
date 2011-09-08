//
//  UIImage+JTImageCrop.m
//  JTImage
//
//  Created by james on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+JTImageCrop.h"

@implementation UIImage (JTImageCrop)

+ (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect {
    NSParameterAssert(image != nil);
    if (CGPointEqualToPoint(CGPointZero, rect.origin) && CGSizeEqualToSize(rect.size, image.size)) {
        return image;
    }

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    [image drawAtPoint:(CGPoint){-rect.origin.x, -rect.origin.y}];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return croppedImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image cropInRelativeRect:(CGRect)rect {
    NSParameterAssert(image != nil);
    if (CGRectEqualToRect(rect, CGRectMake(0, 0, 1, 1))) {
        return image;
    }
    
    CGPoint actualOrigin = (CGPoint){rect.origin.x * image.size.width, rect.origin.y * image.size.height};
    CGSize  actualSize   = (CGSize){rect.size.width * image.size.width, rect.size.height * image.size.height};
    CGRect actualRect = (CGRect){actualOrigin, actualSize};
    return [UIImage imageWithImage:image cropInRect:CGRectIntegral(actualRect)];
}

+ (UIImage *)imageWithImage:(UIImage *)image cropInRatio:(CGSize)ratio {
    NSParameterAssert(image != nil);
    CGFloat targetRatio = ratio.width / ratio.height;
    CGFloat originalRatio = image.size.width / image.size.height;
    
    if (targetRatio == originalRatio) {
        return image;
    }
    
    CGSize targetSize;
    if (targetRatio > originalRatio) {
        // image should become less height
        targetSize = CGSizeMake(image.size.width, image.size.width / targetRatio);
    } else {
        // image should become less width
        targetSize = CGSizeMake(image.size.height * targetRatio, image.size.height);
        
    }
    return [UIImage imageWithImage:image cropInRect:(CGRect){CGPointZero, targetSize}];
}

@end
