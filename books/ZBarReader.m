//
//  ZBarReader.m
//  books
//
//  Created by Andreea Ingrid Funie on 19/06/2011.
//  Copyright 2011 Imperial College London. All rights reserved.
//

#import "ZBarReader.h"
#import "NewDataController.h"


@implementation ZBarReader

@synthesize resultImage, resultText, searchView;

- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
    [reader release];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    
    
    
    
    
    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;
    
    // EXAMPLE: do something useful with the barcode image
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    
    
    //NewDataController *settingDetail = [[NewDataController alloc] initWithNibName:@"NewDataController" bundle:nil];
   // settingDetail.title = @"titlu";
    //[self.navigationController pushViewController:settingDetail animated:YES];
    //[self.navigationController presentModalViewController:settingDetail animated:YES];
    //[settingDetail release];
    
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    self.resultImage = nil;
    self.resultText = nil;
    [super dealloc];
}

@end
