//
//  AlertViewBlocks.m
//
//
//  Created by Danilo Priore on 21/01/14.
//
//

#import "AlertViewBlocks.h"

#if TARGET_OS_TV

@interface AlertViewBlocks()
{
    UIAlertController* alertView;
}

#elif TARGET_OS_SIMULATOR || TARGET_OS_IOS

@interface AlertViewBlocks() <UIAlertViewDelegate>
{
    AlertViewBlocksConfirm confirmBlock;
    AlertViewBlocksCancel cancelBlock;
    AlertViewBlocksIndex indexBlock;
    
    UIAlertView *alertView;
    
}

#endif

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
        
#if TARGET_OS_TV
        
        alertView = [UIAlertController alertControllerWithTitle:title
                                                        message:message
                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        
        if (cancel) {
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:yesNo ? NSLocalizedString(@"No", nil) : NSLocalizedString(@"Cancel", nil)
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                                                                     cancel();
                                                                 }];
            [alertView addAction:cancelAction];
        }
        
        if (confirm) {
            UIAlertAction* okAction = [UIAlertAction actionWithTitle:yesNo ? NSLocalizedString(@"Yes", nil) : NSLocalizedString(@"Ok", nil)
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 confirm();
                                                             }];
            [alertView addAction:okAction];
            
        }
        
        UIViewController* controller = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
        [controller presentViewController:alertView animated:YES completion:nil];
        
#elif TARGET_OS_SIMULATOR || TARGET_OS_IOS
        
        indexBlock = nil;
        confirmBlock = [confirm copy];
        cancelBlock = [cancel copy];

        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:yesNo ? NSLocalizedString(@"No", nil) : NSLocalizedString(@"Cancel", nil) otherButtonTitles:yesNo ? NSLocalizedString(@"Yes", nil) : NSLocalizedString(@"Ok", nil), nil];
        [alertView show];
        
#endif
        
    }
    
    return self;
}

- (id)initAlertViewWithTitle:(NSString*)title message:(NSString*)message confirm:(AlertViewBlocksConfirm)confirm
{
    if (self = [super init]) {
        
#if TARGET_OS_TV

        alertView = [UIAlertController alertControllerWithTitle:title
                                                        message:message
                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        
        if (confirm) {
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                                                                     confirm();
                                                                 }];
            [alertView addAction:cancelAction];
        }
        
        UIViewController* controller = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
        [controller presentViewController:alertView animated:YES completion:nil];
        
#elif TARGET_OS_SIMULATOR || TARGET_OS_IOS
        
        indexBlock = nil;
        confirmBlock = nil;
        cancelBlock = [confirm copy];

        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
        [alertView show];
        
#endif

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
        
#if TARGET_OS_TV
        
        alertView = [UIAlertController alertControllerWithTitle:title
                                                        message:message
                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        if (cancel) {
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                                                                     cancel();
                                                                 }];
            [alertView addAction:cancelAction];
        }
        
        if (confirm) {
            
            int count = 0;
            for (NSString *arg = firstArg; arg != nil; arg = va_arg(args, NSString*))
            {
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:arg
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction * action) {
                                                                         confirm(count);
                                                                     }];
                [alertView addAction:cancelAction];
                
                count++;
            }
        }
        
        UIViewController* controller = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
        [controller presentViewController:alertView animated:YES completion:nil];
        
#elif TARGET_OS_SIMULATOR || TARGET_OS_IOS
        
        confirmBlock = nil;
        indexBlock = [confirm copy];
        cancelBlock = [cancel copy];
        
        alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        
        for (NSString *arg = firstArg; arg != nil; arg = va_arg(args, NSString*))
        {
            [alertView addButtonWithTitle:arg];
        }
        
        [alertView show];
        
#endif
        
    }
    
    return self;
}

#if !TARGET_OS_TV

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

#endif

@end
