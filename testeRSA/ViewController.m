//
//  ViewController.m
//  testeRSA
//
//  Created by HP Developer on 09/12/14.
//  Copyright (c) 2014 Morbix. All rights reserved.
//

#import "ViewController.h"

#import <MIHPublicKey.h>
#import <MIHPrivateKey.h>
#import <MIHRSAKeyFactory.h>
#import <MIHKeyPair.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testeMIH];
}

- (void)testeMIH
{
    
    MIHRSAKeyFactory *factory = [[MIHRSAKeyFactory alloc] init];
    MIHKeyPair *keyPair       = [factory generateKeyPair];
    
    
    id<MIHPublicKey> publicKey = keyPair.public;
    id<MIHPrivateKey> privateKey = keyPair.private;
    
    NSError *encryptionError = nil;
    NSError *decryptionError = nil;
    
    NSData *messageData = [@"My top secret message" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [publicKey encrypt:messageData error:&encryptionError];
    NSLog(@"%s", encryptedData.bytes);
    
    NSData *decryptedData = [privateKey decrypt:encryptedData error:&decryptionError];
    NSString *messageString = [NSString stringWithUTF8String:decryptedData.bytes];
    NSLog(@"%@", messageString);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
