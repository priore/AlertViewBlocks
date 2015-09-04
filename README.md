**AlertViewBlocks**
================

Makes really easy to use AlertView without having a instance variable.

## How to use


``` objective-c
    [AlertViewBlocks confirmWithTitle:@"Title" message:@"your message here" 
    confirm:^{
        
        NSLog(@"Ok button selected!");
        
    } cancel:^{
        
        NSLog(@"Cancel button selected!");

    }];

```

``` objective-c
    [AlertViewBlocks confirmWithTitle:@"Title" message:@"your message here" 
    YesNo:YES confirm:^{
        
        NSLog(@"Yes button selected!");
        
    } cancel:^{
        
        NSLog(@"No button selected!");

    }];
```

``` objective-c
    [AlertViewBlocks alertWithTitle:@"Title" message:@"you message here" confirm:^(NSInteger index) {

        NSLog(@"Button #%i selected!", index);
    
    } cancel:^{

        NSLog(@"Cancel button selected!");
    
    } otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", nil];
```