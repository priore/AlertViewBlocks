//
//  AlertViewBlocks.h
//
//
//  Created by Danilo Priore on 21/01/14.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^AlertViewBlocksConfirm)();
typedef void(^AlertViewBlocksCancel)();
typedef void(^AlertViewBlocksIndex)(NSInteger index);

@interface AlertViewBlocks : NSObject

+ (void)confirmWithTitle:(NSString*)title
                 message:(NSString*)message
                 confirm:(AlertViewBlocksConfirm)confirm
                  cancel:(AlertViewBlocksCancel)cancel;

+ (void)confirmWithTitle:(NSString*)title
                 message:(NSString*)message
                    YesNo:(BOOL)yesNo
                 confirm:(AlertViewBlocksConfirm)confirm
                  cancel:(AlertViewBlocksCancel)cancel;

+ (void)confirmWithTitle:(NSString *)title
                 message:(NSString *)message
                 confirm:(AlertViewBlocksCancel)confirm;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
               confirm:(AlertViewBlocksIndex)confirm
                cancel:(AlertViewBlocksCancel)cancel
     otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
