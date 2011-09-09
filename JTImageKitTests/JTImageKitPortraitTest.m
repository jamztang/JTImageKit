//
//  JTImageKitPortraitTest.m
//  JTImageKit
//
//  Created by james on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JTImageKitPortraitTest.h"
#import "UIImage+JTImageCrop.h"

@implementation JTImageKitPortraitTest
@synthesize image;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    self.image = [UIImage imageNamed:@"portrait.JPG"];
}

- (void)tearDown
{
    // Tear-down code here.
    self.image = nil;
    
    [super tearDown];
}

- (void)testCGImageCreateWithImageInRelativeRectWithRatio {
    CGImageRef sourceImage = self.image.CGImage;
    CGImageRef targetImage = CGImageCreateWithImageInRelativeRectWithRatio(sourceImage, (CGRect){{0.162413, 0.015625}, {0.719258, 0.96875}}, CGSizeMake(1, 1));
    CGSize targetSize = CGSizeMake(CGImageGetWidth(targetImage), CGImageGetHeight(targetImage));
    STAssertEquals(targetSize, CGSizeMake(1865, 1865), @"targetSize %@", NSStringFromCGSize(targetSize));
    CGImageRelease(targetImage);
}

@end
