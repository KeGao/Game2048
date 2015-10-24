//
//  VCRoot.h
//  Game2048
//
//  Created by qianfeng on 14-8-25.
//  Copyright (c) 2014年 gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCRoot : UIViewController <UIAlertViewDelegate>
{
    UIView *_bgView;
    NSMutableArray *_arrayLabels;
    UILabel *_MAXScore;
    int maxScore;
    
    BOOL isChangeR;
    BOOL isChangeL;
    BOOL isChangeU;
    BOOL isChangeD;
}

@end
