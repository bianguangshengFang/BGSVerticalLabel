//
//  BgsVerticalLabel.m
//  zhexianProject
//
//  Created by bianguangsheng on 2017/3/2.
//  Copyright © 2017年 soufunnet. All rights reserved.
//

#import "BgsVerticalLabel.h"

@implementation BgsVerticalLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame  withText:(NSString *)text ratateAngle:(float)angle{
    if (self=[super initWithFrame:frame]) {
        //custom code
        
        UILabel *lb=[self createLabelWithRect:self.bounds Text:text ratateAngle:angle];
        [self addSubview:lb];
        
        
        
        
    }
    return self;
}

- (UILabel *)createLabelWithRect:(CGRect)rect Text:(NSString *)text ratateAngle:(float)angle{
    
    NSString *verticalText=[self backVerticalStrWithStr:text];
    NSAttributedString *att=[[NSAttributedString alloc]initWithString:verticalText attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor],NSVerticalGlyphFormAttributeName:[NSNumber numberWithInteger:1],NSObliquenessAttributeName:[NSNumber numberWithFloat:0]}];
    UILabel *verticalLb=[[UILabel alloc]initWithFrame:rect];
    verticalLb.backgroundColor=[UIColor greenColor];
    verticalLb.attributedText=att;
    verticalLb.lineBreakMode=NSLineBreakByWordWrapping;
    verticalLb.numberOfLines=0;
    verticalLb.transform=CGAffineTransformMakeRotation(angle);//顺时针为正，逆时针为负
    verticalLb.textAlignment=NSTextAlignmentCenter;
    [verticalLb sizeToFit];
    //    [self.view addSubview:verticalLb];
    return verticalLb;
    
    
    
    
}
- (NSString *)backVerticalStrWithStr:(NSString *)withStr{
    NSString *wstr=withStr;
    if ([wstr containsString:@"-"]) {
        wstr=[wstr stringByReplacingOccurrencesOfString:@"-" withString:@"|"];
        
    }
    NSAttributedString *waitStr=[[NSAttributedString alloc]initWithString:wstr];
    
    NSMutableString *mstr=[NSMutableString string];
    //    NSArray *array=[waitStr componentsSeparatedByString:@""];
    NSRange range;
    for(int i=0; i<waitStr.length; i+=range.length)
    {
        range = [waitStr.string rangeOfComposedCharacterSequenceAtIndex:i];
        NSAttributedString *s = [waitStr attributedSubstringFromRange:range];
        NSLog(@"s:%@",s.string);
        [mstr appendString:s.string];
        int a=[ self backCharacterTypeWithSingleWord:s.string];
        int b=-1;
        if (i<waitStr.string.length-1 ){
            NSRange  range1= [waitStr.string rangeOfComposedCharacterSequenceAtIndex:i+1];
            NSAttributedString *s1 = [waitStr attributedSubstringFromRange:range1];
            b=[self backCharacterTypeWithSingleWord:s1.string];
            if (a==b&&a!=40&&b!=40) {
                //前后两个字符属于同类且都不属于标点符号
                if (a==b&&a==10) {
                    [mstr appendString:@"\n"];
                    
                }
                
            }else{
                [mstr appendString:@"\n"];
            }
        }
        
        
    }
    NSLog(@"mstr:%@",mstr);
    return mstr;
    
}
-(int)backCharacterTypeWithSingleWord:(NSString *)word{
    int a =[word characterAtIndex:0];
    NSLog(@"a:%d word:%@",a,word);
    if (a>0x4e00&&a<0x9fff) {
        NSLog(@"ischiese");
        return 10;
        
    }
    else if ((a>='a'&&a<='z')||(a>='A'&&a<='Z')){
        NSLog(@"isEnglishCharcter");
        return 20;
        
    }
    else if (a>='0'&&a<='9'){
        NSLog(@"isNumber ");
        return 30;
        
    }
    
    else{
        NSLog(@"这是标点符号");
        return 40;
    }
    
}











@end
