//
//  DocMyViewController.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/7.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface DocMyViewController : MDBaseViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
