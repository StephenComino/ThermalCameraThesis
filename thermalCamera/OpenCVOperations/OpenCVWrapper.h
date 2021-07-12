//
//  OpenCVWrapper.h
//  thermalCamera
//
//  Created by Stephanie Shore on 14/6/21.
//

#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+ (UIImage *)toGray:(UIImage *)source display: (int)display_style;
+ (void) processImage:(UIImage *)image;
@end
