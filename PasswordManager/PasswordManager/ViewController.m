//
//  ViewController.m
//  PasswordManager
//
//  Created by jacdevos on 2016/12/05.
//  Copyright © 2016 nReality. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)addPassword:(UIButton *)sender {
    
    if (!self.emailTextField.text.length)
    {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Invalid email"
                                    message:@"User email cannot be empty."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    //TODO email regex validation
    
    
    if (!self.passwordTextField.text.length)
    {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Invalid password"
                                    message:@"Password cannot be empty."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    if (self.passwordTextField.text.length < 6)
    {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Invalid password"
                                    message:@"Password be at least 6 chars."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    const char *s=[self.passwordTextField.text cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:hash
                     forKey:@"passwordHash"];
    
    [userDefaults setObject:self.emailTextField.text
                     forKey:@"email"];

    [userDefaults synchronize];
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Add successful"
                                message:@"Email and password saved."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (IBAction)checkPassword:(id)sender {
    
    NSString *passwordHash = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwordHash"];
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    
   
    if (!passwordHash.length || !email.length)
    {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Check failed"
                                    message:@"No email or password saved."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    const char *s=[self.passwordTextField.text cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    if (![email isEqual:self.emailTextField.text]){
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Check failed"
                                    message:@"Emails don't match."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (![passwordHash isEqual:hash]){
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Check failed"
                                    message:@"Passwords don't match."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    

    UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Add successful"
                                    message:@"Email and password match the saved one."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    return;

}


@end
