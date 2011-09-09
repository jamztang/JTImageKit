//
//  JTImageKitTests.m
//  JTImageKitTests
//
//  Created by james on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JTImageKitTests.h"
#import "UIImage+JTImageCrop.h"

@implementation JTImageTests
@synthesize image;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    self.image = [UIImage imageNamed:@"sample.png"];
}

- (void)tearDown
{
    // Tear-down code here.
    self.image = nil;
    
    [super tearDown];
}

- (void)testCropInRect {
    UIImage *croppedImage = [UIImage imageWithImage:self.image cropInRect:CGRectMake(10, 10, 10, 10)];
    STAssertNotNil(croppedImage, @"Should contains image", nil);
    
    STAssertTrue(CGSizeEqualToSize(CGSizeMake(10, 10), croppedImage.size), @"Size must be 10x10", nil);
}

- (void)testCropInRelativeRect {
    UIImage *croppedImage = [UIImage imageWithImage:self.image cropInRelativeRect:CGRectMake(0.5, 0.5, 0.25, 0.25)];
    STAssertNotNil(croppedImage, @"Should contains image", nil);
    STAssertTrue(CGSizeEqualToSize(CGSizeMake(250, 250), croppedImage.size), @"size %@ must be equal to 250 * 250", NSStringFromCGSize(croppedImage.size));
}

- (void)testCropInRatio {
    UIImage *croppedImage = [UIImage imageWithImage:self.image cropInRatio:CGSizeMake(2, 1)];
    STAssertNotNil(croppedImage, @"Should contains image", nil);
    STAssertTrue(CGSizeEqualToSize(CGSizeMake(1000, 500), croppedImage.size), @"size %@ must be equal to 1000 * 500", NSStringFromCGSize(croppedImage.size));
}

- (void)testEarlyCropInRatio {
    UIImage *croppedImage = [UIImage imageWithImage:self.image cropInRatio:CGSizeMake(1, 1)];
    STAssertTrue(croppedImage == self.image, @"Should not return a new image", nil);
}

- (void)testEarlyCropInRect {
    UIImage *croppedImage = [UIImage imageWithImage:self.image cropInRect:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
    STAssertTrue(croppedImage == self.image, @"Should not return a new image", nil);
}

- (void)testEarlyCropInRelativeRect {
    UIImage *croppedImage = [UIImage imageWithImage:self.image cropInRelativeRect:CGRectMake(0, 0, 1, 1)];
    STAssertTrue(croppedImage == self.image, @"Should not return a new image", nil);
}

- (void)testCGImageCreateWithImageInRelativeRect {
    CGImageRef sourceImage = self.image.CGImage;
    CGImageRef targetImage = CGImageCreateWithImageInRelativeRect(sourceImage, CGRectMake(0.5, 0.5, 0.25, 0.5));
    CGSize targetSize = CGSizeMake(CGImageGetWidth(targetImage), CGImageGetHeight(targetImage));
    STAssertEquals(targetSize, CGSizeMake(250, 500), @"targetSize %@", NSStringFromCGSize(targetSize));
    CGImageRelease(targetImage);
}

- (void)testCGSizeConstrainedInRatio {
    CGSize size = CGSizeMake(1000, 1000);
    CGSize newSize = CGSizeConstrainedInRatio(size, CGSizeMake(2, 1));
    STAssertEquals(newSize, CGSizeMake(1000, 500), @"but newSize is %@", NSStringFromCGSize(newSize));
}

- (void)testCGImageCreateWithImageInRelativeRectWithRatio {
    CGImageRef sourceImage = self.image.CGImage;
    CGImageRef targetImage = CGImageCreateWithImageInRelativeRectWithRatio(sourceImage, CGRectMake(0.5, 0.5, 0.4, 0.5), CGSizeMake(4, 3));
    CGSize targetSize = CGSizeMake(CGImageGetWidth(targetImage), CGImageGetHeight(targetImage));
    STAssertEquals(targetSize, CGSizeMake(400, 300), @"targetSize %@", NSStringFromCGSize(targetSize));
    CGImageRelease(targetImage);
}

@end
