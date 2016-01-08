//
//  DocPatientSQL.h
//  MyDoctor
//
//  Created by 张昊辰 on 16/1/8.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocPatientSQL : NSObject

-(void)createAttachmentsDBTableWithPatient;
-(void)updatePopAttachmentsDBTable:(NSArray *)attachmentArr;
-(NSArray *)getAttachmentswithMailPhone:(NSString *)Phone ;


@end
