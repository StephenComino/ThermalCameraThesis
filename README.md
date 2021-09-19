
# Networked Thermal Imaging Camera

This devide is an IoT Networked thermal Imaging Camera.
There is two parts to it:

1. A Python3 server running on a Raspberry Pi 4. That is repsonsible for hosting a Flir lepton 3 thermal Camera and Intel Realsense Depth Camera
2. An app written in Swift 5 that lets you control the device.

## Currently supported behavior:
1. Take thermal readings of specific locations
2. Take a photo of the screen, and save that photo on your phone
3. Change the thermal colour scheme
4. 

## todo
- [ ] - Calibrate the thermal Camera (Flir Lepton 3) with the Intel Realsense Depth Camera (Stereo Callibration)
- [ ] - Return Depth data with the Thermal Data for Iphone 7
- [ ] - Zoom in / Zoom out features
- [ ] - Test and remove Bugs from Iphone application
- [ ] - Upload Steps and code to repreoduce product to this page.
