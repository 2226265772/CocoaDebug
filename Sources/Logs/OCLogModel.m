//
//  OCLogModel.m
//  Example_Swift
//
//  Created by man on 2018/12/14.
//  Copyright © 2018年 liman. All rights reserved.
//

#import "OCLogModel.h"
#import "OCLoggerFormat.h"
#import "NetworkHelper.h"

@implementation OCLogModel

- (instancetype)initWithContent:(NSString *)content color:(UIColor *)color fileInfo:(NSString *)fileInfo isTag:(BOOL)isTag
{
    if (self = [super init]) {
        self.Id = [[NSUUID UUID] UUIDString];
        self.fileInfo = fileInfo;
        self.content = content;
        self.date = [NSDate date];
        self.color = color;
        self.isTag = isTag;
        
        /////////////////////////////////////////////////////////////////////////
        
        NSInteger startIndex = 0;
        NSInteger lenghtDate = 0;
        NSString *stringContent = @"";
        
        stringContent = [stringContent stringByAppendingFormat:@"[%@]", [OCLoggerFormat formatDate:self.date]];
        lenghtDate = [stringContent length];
        startIndex = [stringContent length];
        
        if (self.fileInfo) {
            stringContent = [stringContent stringByAppendingFormat:@"%@%@", self.fileInfo, self.content];
        }else{
            stringContent = [stringContent stringByAppendingFormat:@"%@", self.content];
        }
    
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:stringContent];
        [attstr addAttribute:NSForegroundColorAttributeName value:self.color range:NSMakeRange(0, [stringContent length])];
        
        NSRange range = NSMakeRange(0, lenghtDate);
        [attstr addAttribute:NSForegroundColorAttributeName value: [[NetworkHelper shared] mainColor] range: range];
        [attstr addAttribute:NSFontAttributeName value: [UIFont boldSystemFontOfSize:12] range: range];
        
        NSRange range2 = NSMakeRange(startIndex, self.fileInfo.accessibilityElementCount);
        [attstr addAttribute: NSForegroundColorAttributeName value: [UIColor grayColor]  range: range2];
        [attstr addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize:12] range: range2];
        
        self.str = stringContent;
        self.attr = [attstr copy];
    }
    
    return self;
}

@end
