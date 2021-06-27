//
//  OpenCVWrapper.m
//  OpenCV
//
//  Created by Dmytro Nasyrov on 5/1/17.
//  Copyright © 2017 Pharos Production Inc. All rights reserved.
//

#ifdef __cplusplus
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"

#pragma clang pop
#endif

using namespace std;
using namespace cv;

#pragma mark - Private Declarations

@interface OpenCVWrapper ()

#ifdef __cplusplus

+ (Mat)_grayFrom:(Mat)source;
+ (Mat)_matFrom:(UIImage *)source;
+ (UIImage *)_imageFrom:(Mat)source;
+ (void) processImage:(UIImage *)image;

#endif

@end

#pragma mark - OpenCVWrapper

@implementation OpenCVWrapper

#pragma mark Public

+ (UIImage *)toGray:(UIImage *)source {
    //cout << "OpenCV: ";
    return [OpenCVWrapper _imageFrom:[OpenCVWrapper _grayFrom:[OpenCVWrapper _matFrom:source]]];
}

#pragma mark Private

+ (Mat)_grayFrom:(Mat)source {
    //cout << "-> grayFrom ->";
    
    Mat result;
    Mat img_color;
    // Apply the colormap:
    
    // Apply the different colorMaps Here
     //cv::COLORMAP_AUTUMN = 0,
     //cv::COLORMAP_BONE = 1,
     //cv::COLORMAP_JET = 2,
     //cv::COLORMAP_WINTER = 3,
     //cv::COLORMAP_RAINBOW = 4,
     //cv::COLORMAP_OCEAN = 5,
     //cv::COLORMAP_SUMMER = 6,
     //cv::COLORMAP_SPRING = 7,
     //cv::COLORMAP_COOL = 8,
     //cv::COLORMAP_HSV = 9,
     //cv::COLORMAP_PINK = 10,
     //cv::COLORMAP_HOT = 11,
     //cv::COLORMAP_PARULA = 12,
     //cv::COLORMAP_MAGMA = 13,
     //cv::COLORMAP_INFERNO = 14,
     //cv::COLORMAP_PLASMA = 15,
     //cv::COLORMAP_VIRIDIS = 16,
     //cv::COLORMAP_CIVIDIS = 17,
     //cv::COLORMAP_TWILIGHT = 18,
     //cv::COLORMAP_TWILIGHT_SHIFTED = 19,
     //cv::COLORMAP_TURBO = 20,
     //cv::COLORMAP_DEEPGREEN = 21
    cv::applyColorMap(source, img_color, COLORMAP_CIVIDIS);
    
    return img_color;
}

+ (void) processImage:(UIImage *)image{
     /** processImage is a callback function, which is called for every frame captured by the camera. */
    cv::Mat image_mat = [OpenCVWrapper _matFrom:image];
    //cv::Mat img = cv::imdecode(image_mat, IMREAD_ANYCOLOR);
    image_mat *= 0.01;
    image_mat -= 273.15;
    cout << "M = " << endl << " "  <<  image_mat << endl << endl;
    //param.push_back(IMWRITE_JPEG_QUALITY);
      //param.push_back(40); /* jpeg quality */
     //cv::Mat image_copy(cv::Size(120,160), CV_8UC3, cv::Scalar(0));
    //cv::Mat outputFrame(cv::Size(120,160), CV_8UC3, cv::Scalar(0));
    //cv::cvtColor(image_mat, image_copy, COLOR_BGRA2BGR);
    // cv::imencode(".jpg", image_copy, buff, param);
        
     //NSLog(@"Size using jpg compression %d, ", buff[1]);
    
    
    //cv::imdecode(image_mat, IMREAD_ANYCOLOR, &outputFrame);
    //uchar * arr = outputFrame.isContinuous()? outputFrame.data: outputFrame.clone().data;
    //cv::Mat flat = outputFrame.reshape(1, outputFrame.total()*outputFrame.channels());
    //std::vector<int> vec = outputFrame.isContinuous()? flat : flat.clone();
    //cout << "M = " << endl << " "  <<  outputFrame << endl << endl;
    
    //NSLog(@"Size using jpg compression %d, ",(int) outputFrame.rowRange(0, 10));
     //NSLog(buff);
     /** Testing the encode and the decode functions. */
}

+ (Mat)_matFrom:(UIImage *)source {
    //cout << "matFrom ->";
    
    CGImageRef image = CGImageCreateCopy(source.CGImage);
 
    CGFloat cols = CGImageGetWidth(image);
    //cout << "Width " << cols << endl;
    CGFloat rows = CGImageGetHeight(image);
    //cout << "Height " << rows << endl;
    Mat result(rows, cols, CV_8U);

    CGBitmapInfo bitmapFlags = kCGBitmapByteOrderDefault;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = result.step[0];
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image);
    
    CGContextRef context = CGBitmapContextCreate(result.data, cols, rows, bitsPerComponent, bytesPerRow, colorSpace, bitmapFlags);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, cols, rows), image);
    CGContextRelease(context);
    
    return result;
}

+ (UIImage *)_imageFrom:(Mat)source {
    //cout << "-> imageFrom\n";
    
    NSData *data = [NSData dataWithBytes:source.data length:source.elemSize() * source.total()];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);

    CGBitmapInfo bitmapFlags = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = source.step[0];
    CGColorSpaceRef colorSpace = (source.elemSize() == 1 ? CGColorSpaceCreateDeviceGray() : CGColorSpaceCreateDeviceRGB());
    
    CGImageRef image = CGImageCreate(source.cols, source.rows, bitsPerComponent, bitsPerComponent * source.elemSize(), bytesPerRow, colorSpace, bitmapFlags, provider, NULL, false, kCGRenderingIntentDefault);
    UIImage *result = [UIImage imageWithCGImage:image];
    
    CGImageRelease(image);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return result;
}

@end
