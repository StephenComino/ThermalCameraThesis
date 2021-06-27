//
//  OpenCVWrapper.h
//  thermalCamera
//
//  Created by Stephanie Shore on 14/6/21.
//

#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+ (UIImage *)toGray:(UIImage *)source;
+ (void) processImage:(UIImage *)image;
@end
