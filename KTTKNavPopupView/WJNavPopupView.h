//
//  WJNavPopupView.h
//  KTTKNavPopupView
//
//  Created by 王杰 on 2018/11/7.
//  Copyright © 2018 wangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJNavPopupView : UIView
- (id)initWithOptionsArray:(NSArray*)optionArray selectedBlock:(void(^)(NSString *))selectedBlock;




@end

NS_ASSUME_NONNULL_END
