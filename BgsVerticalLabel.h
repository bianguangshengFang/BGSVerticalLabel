//
//  BgsVerticalLabel.h
//  zhexianProject
//
//  Created by bianguangsheng on 2017/3/2.
//  Copyright © 2017年 soufunnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BgsVerticalLabel : UILabel

@property (nonatomic) float rotateAngle;

- (id)initWithFrame:(CGRect)frame  withText:(NSString *)text ratateAngle:(float)angle;


@end
