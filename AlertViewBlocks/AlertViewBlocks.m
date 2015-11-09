//
//  AlertViewBlocks.m
//
//
//  Created by Danilo Priore on 21/01/14.
//
//

#import "AlertViewBlocks.h"

@interface AlertViewBlocks() <UIAlertViewDelegate>
{
    AlertViewBlocksConfirm confirmBlock;
    AlertViewBlocksCancel cancelBlock;
    AlertViewBlocksIndex indexBlock;
    
    UIAlertView *alertView;
}

@end

@implementation AlertViewBlocks

static AlertViewBlocks *alertViewBlocks;

+ (void)confirmWithTitle:(NSString*)title message:(NSString*)message confirm:(AlertViewBlocksConfirm)confirm cancel:(AlertViewBlocksCancel)cancel
{
    alertViewBlocks = [[AlertViewBlocks alloc] initConfirmViewWithTitle:title message:message confirm:confirm cancel:cancel];
}

+ (void)confirmWithTitle:(NSString *)title message:(NSString *)message confirm:(AlertViewBlocksCancel)confirm
{
    alertViewBlocks = [[AlertViewBlocks alloc] initAlertViewWithTitle:title message:message confirm:confirm];
}

+ (void)confirmWithTitle:(NSString*)title message:(NSString*)message YesNo:(BOOL)yesNo confirm:(AlertViewBlocksConfirm)confirm cancel:(AlertViewBlocksCancel)cancel
{
    alertViewBlocks = [[AlertViewBlocks alloc] initConfirmViewWithTitle:title message:message YesNo:yesNo confirm:confirm cancel:cancel];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirm:(AlertViewBlocksIndex)confirm cancel:(AlertViewBlocksCancel)cancel otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    va_list args;
    va_start(args, otherButtonTitles);
    alertViewBlocks = [[AlertViewBlocks alloc] initAlertWithTitle:title message:message cancelButtonTitle:(cancel ? NSLocalizedString(@"Cancel", nil) : nil) confirm:confirm cancel:cancel firstArgument:otherButtonTitles arguments:args];
    va_end(args);
}

- (id)initConfirmViewWithTitle:(NSString*)title message:(NSString*)message confirm:(AlertViewBlocksConfirm)confirm cancel:(AlertViewBlocksCancel)cancel
{
    return [self initConfirmViewWithTitle:title message:message YesNo:NO confirm:confirm cancel:cancel];
}

- (id)initConfirmViewWithTitle:(NSString*)title message:(NSString*)message YesNo:(BOOL)yesNo confirm:(AlertViewBlocksConfirm)confirm cancel:(AlertViewBlocksCancel)cancel
{
    if (self = [super init]) {
        indexBlock = nil;
        confirmBlock = [confirm copy];
        cancelBlock = [cancel copy];
        
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:yesNo ? NSLocalizedString(@"No", nil) : NSLocalizedString(@"Cancel", nil) otherButtonTitles:yesNo ? NSLocalizedString(@"Yes", nil) : NSLocalizedString(@"Ok", nil), nil];
        [alertView show];
        
    }
    
    return self;
}

- (id)initAlertViewWithTitle:(NSString*)title message:(NSString*)message confirm:(AlertViewBlocksConfirm)confirm
{
    if (self = [super init]) {
        indexBlock = nil;
        confirmBlock = nil;
        cancelBlock = [confirm copy];
        
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
        [alertView show];
    }
    
    return self;
}

- (id)initAlertWithTitle:(NSString *)title
                 message:(NSString *)message
       cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirm:(AlertViewBlocksIndex)confirm
                  cancel:(AlertViewBlocksCancel)cancel
           firstArgument:(NSString*)firstArg
               arguments:(va_list)args
{
    if (self = [super init]) {
        confirmBlock = nil;
        indexBlock = [confirm copy];
        cancelBlock = [cancel copy];
        
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        
        for (NSString *arg = firstArg; arg != nil; arg = va_arg(args, NSString*))
        {
            [alertView addButtonWithTitle:arg];
        }
        
        [alertView show];
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (indexBlock) {
        indexBlock(buttonIndex);
    } else {
        switch (buttonIndex) {
            case 0: // cancel
                if (cancelBlock) cancelBlock();
                break;
            case 1: // ok
                if (confirmBlock) confirmBlock();
            default:
                break;
        }
    }
}

- (void)dealloc
{
    confirmBlock = nil;
    cancelBlock = nil;
    indexBlock = nil;
    alertView = nil;
}

@end
