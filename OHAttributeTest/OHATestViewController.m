//
//  OHATestViewController.m
//  OHAttributeTest
//
//  Created by Shiina Ahmad on 2013/01/16.
//  Copyright (c) 2013年 Shiina Ahmad. All rights reserved.
//

#import "OHATestViewController.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@interface OHATestViewController ()

@end

@implementation OHATestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // create ohlabel
    OHAttributedLabel *ohLabel = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 80, 300, 100)] autorelease];
    ohLabel.backgroundColor = [UIColor clearColor];
    ohLabel.numberOfLines = 2;
    ohLabel.automaticallyAddLinksForType = NO; // disable auto-link
    
    // sample text
    NSString *txt = @"Go visit https://github.com/ashiina for my repo!\nThis is a wonderful library!";
    NSMutableAttributedString *attrStr = [NSMutableAttributedString attributedStringWithString:txt];

    // set style for a word
    [attrStr setTextColor:[UIColor blueColor]
                    range:[txt rangeOfString:@"wonderful"]];
    
    // extract url
    NSString *foundUrl = [self _extractUrl:txt];
    
    // define range of url
    NSRange linkRange = [txt rangeOfString:foundUrl];
    
    // Set linkUrl and style.
    // Note that the linkUrl is being modified here
    NSString *linkUrl = [NSString stringWithFormat:@"%@?tab=repositories", foundUrl];
    [attrStr setLink:[NSURL URLWithString:linkUrl]
               range:linkRange];
    [attrStr setTextColor:[UIColor redColor]
                    range:linkRange];
    
    // set attributedText
    ohLabel.attributedText = attrStr;
    ohLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:ohLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Extract URL.
// Maybe the logic is not too good... It only finds one URL, and returns it instantly
- (NSString *) _extractUrl:(NSString *) targetStr
{
    NSArray *strArray = [targetStr componentsSeparatedByString:@" "];
    for (NSString *subStr in strArray) {
        NSRange match_link2 = [subStr rangeOfString:@"https?://" options:NSRegularExpressionSearch];
        if (match_link2.location != NSNotFound) {
            NSLog(@"found URL:%@",subStr);
            return [NSString stringWithFormat:@"%@",subStr];
        }
    }
    return NO;
}

@end
