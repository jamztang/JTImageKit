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
    
    CGRect imageRect = (CGRect){CGPointZero, image.size};
    CGRect actualRect = CGRectTransformToRect(rect, imageRect);
    return [UIImage imageWithImage:image cropInRect:CGRectIntegral(actualRect)];
}

+ (UIImage *)imageWithImage:(UIImage *)image cropInRatio:(CGSize)ratio {
    NSParameterAssert(image != nil);
    CGFloat targetRatio = ratio.width / ratio.height;
    CGFloat originalRatio = image.size.width / image.size.height;
    
    if (targetRatio == originalRatio) {
        return image;
    }
    
    CGSize targetSize = CGSizeConstrainedInRatio(image.size, ratio);
    return [UIImage imageWithImage:image cropInRect:(CGRect){CGPointZero, targetSize}];
}

@end

CGSize CGSizeConstrainedInRatio(CGSize originalSize, CGSize ratio) {
    CGFloat targetRatio = ratio.width / ratio.height;
    CGFloat originalRatio = originalSize.width / originalSize.height;

    CGSize targetSize;
    if (targetRatio > originalRatio) {
        // image should become less height
        targetSize = CGSizeMake(originalSize.width, originalSize.width / targetRatio);
    } else {
        // image should become less width
        targetSize = CGSizeMake(originalSize.height * targetRatio, originalSize.height);
    }
    return targetSize;
}

CGRect CGRectTransformToRect(CGRect fromRect, CGRect toRect) {
    CGPoint actualOrigin = (CGPoint){fromRect.origin.x * CGRectGetWidth(toRect), fromRect.origin.y * CGRectGetHeight(toRect)};
    CGSize  actualSize   = (CGSize){fromRect.size.width * CGRectGetWidth(toRect), fromRect.size.height * CGRectGetHeight(toRect)};
    return (CGRect){actualOrigin, actualSize};
}

CGImageRef CGImageCreateWithImageInRelativeRect(CGImageRef image, CGRect rect) {
    CGRect imageRect = (CGRect){CGPointZero, CGImageGetWidth(image), CGImageGetHeight(image)};
    return CGImageCreateWithImageInRect(image, CGRectTransformToRect(rect, imageRect));
}


CGImageRef CGImageCreateWithImageInRelativeRectWithRatio(CGImageRef image, CGRect rect, CGSize ratio) {
    CGRect imageRect = (CGRect){CGPointZero, CGImageGetWidth(image), CGImageGetHeight(image)};
    CGRect targetRect = (CGRect)CGRectTransformToRect(rect, imageRect);
    CGSize targetSize = CGSizeConstrainedInRatio(targetRect.size, ratio);
    // origin should cast to integer, size will be automatically integral by CGImageCreateWithImageInRect
    targetRect = (CGRect){(int)(0.5+targetRect.origin.x), (int)(0.5+targetRect.origin.y), targetSize};
    return CGImageCreateWithImageInRect(image, targetRect);
}


