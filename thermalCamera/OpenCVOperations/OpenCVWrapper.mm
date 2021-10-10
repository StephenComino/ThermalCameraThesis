//
//  OpenCVWrapper.m
//  OpenCV
//
//  Adapted by Stephen Comino
//  From https://medium.com/salt-pepper/opencv-swift-wrapper-6947ba236809
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

+ (Mat)_colorFrom:(Mat)source display: (int) display_style;
+ (Mat)_matFrom:(UIImage *)source;
+ (UIImage *)_imageFrom:(Mat)source;
+ (void) processImage:(UIImage *)image;

#endif

@end

#pragma mark - OpenCVWrapper

@implementation OpenCVWrapper

#pragma mark Public

// Add Zoom to this function
+ (UIImage *)toGray:(UIImage *)source display: (int)display_style {
    return [OpenCVWrapper _imageFrom:[OpenCVWrapper _colorFrom:[OpenCVWrapper _matFrom:source] display:display_style]];
}

#pragma mark Private

+ (Mat)_colorFrom:(Mat)source display: (int) display_style{
    //cout << "-> grayFrom ->";
    Mat result;
    Mat img_color;

    switch (display_style) {
        case -1:
            //cv::detailEnhance(source, source, 10.0, 0.15);
            cv::applyColorMap(source, img_color, COLORMAP_BONE);
            break;
        case 0:
            // Light blue to Dark Blue
            cv::applyColorMap(source, img_color, COLORMAP_AUTUMN);
            
            break;
        case 1:
            cv::applyColorMap(source, img_color, COLORMAP_BONE);
            
            break;
        case 2:
            cv::applyColorMap(source, img_color, COLORMAP_JET);
            
            break;
        case 3:
            cv::applyColorMap(source, img_color, COLORMAP_WINTER);
            
            break;
        case 4:
            cv::applyColorMap(source, img_color, COLORMAP_RAINBOW);
            
            break;
        case 5:
            cv::applyColorMap(source, img_color, COLORMAP_OCEAN);
            
            break;
        case 6:
            cv::applyColorMap(source, img_color, COLORMAP_SUMMER);
            
            break;
        case 7:
            cv::applyColorMap(source, img_color, COLORMAP_SPRING);
            
            break;
        case 8:
            cv::applyColorMap(source, img_color, COLORMAP_COOL);
            
            break;
        case 9:
            cv::applyColorMap(source, img_color, COLORMAP_HSV);
            
            break;
        case 10:
            cv::applyColorMap(source, img_color, COLORMAP_PINK);
            
            break;
        case 11:
            cv::applyColorMap(source, img_color, COLORMAP_HOT);
            
            break;
        case 12:
            cv::applyColorMap(source, img_color, COLORMAP_PARULA);
            
            break;
        case 13:
            cv::applyColorMap(source, img_color, COLORMAP_MAGMA);
            
            break;
        case 14:
            cv::applyColorMap(source, img_color, COLORMAP_INFERNO);
            
            break;
        case 15:
            cv::applyColorMap(source, img_color, COLORMAP_PLASMA);
            
            break;
        case 16:
            cv::applyColorMap(source, img_color, COLORMAP_VIRIDIS);
            
            break;
        case 17:
            cv::applyColorMap(source, img_color, COLORMAP_CIVIDIS);
            
            break;
        case 18:
            cv::applyColorMap(source, img_color, COLORMAP_TWILIGHT);
            
            break;
        case 19:
            cv::applyColorMap(source, img_color, COLORMAP_TWILIGHT_SHIFTED);
            
            break;
        case 20:
            cv::applyColorMap(source, img_color, COLORMAP_TURBO);
            
            break;
        default:
            cv::applyColorMap(source, img_color, COLORMAP_BONE);
            break;
    }
    //cv::resize(img_color, img_color, cv::Size(img_color.cols/4, img_color.rows/4));
    
    return img_color;
}

+ (void) processImage:(UIImage *)image{
     /** processImage is a callback function, which is called for every frame captured by the camera. */
    cv::Mat image_mat = [OpenCVWrapper _matFrom:image];
    //cv::Mat img = cv::imdecode(image_mat, IMREAD_ANYCOLOR);
    image_mat *= 0.01;
    image_mat -= 273.15;
    cout << "M = " << endl << " "  <<  image_mat << endl << endl;
  
}

+ (Mat)_matFrom:(UIImage *)source {
    //cout << "matFrom ->";
    
    CGImageRef image = CGImageCreateCopy(source.CGImage);
    CGFloat cols = CGImageGetWidth(image);
    //cout << "Width " << cols << endl;
    CGFloat rows = CGImageGetHeight(image);
    //cout << "Height " << rows << endl;
    Mat result(rows, cols, CV_8U);
    Mat result2(rows, cols, CV_8U);
    //Mat result(rows, cols, CV_8UC3, Scalar(1,2,3)); // 8 bits per component, 4 channels
    CGBitmapInfo bitmapFlags = kCGBitmapByteOrderDefault;
    // KCGImageAlphaNone |
    //CGBitmapInfo bitmapFlags = kCGImageAlphaNoneSkipLast|kCGBitmapFloatComponents;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = result.step[0];
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image);
    //cv::cvtColor(result, result, COLOR_GRAY2RGB);
    
    CGContextRef context = CGBitmapContextCreate(result.data, cols, rows, bitsPerComponent, bytesPerRow, colorSpace, bitmapFlags);
    //cv::detailEnhance(result, result, 10.0, 0.15);
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
