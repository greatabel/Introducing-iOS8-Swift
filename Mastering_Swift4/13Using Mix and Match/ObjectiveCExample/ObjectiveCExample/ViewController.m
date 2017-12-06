#import "ViewController.h"
#import "ObjectiveCExample-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)messagePressed:(id)sender {
    MessageBuilder *mb = [[MessageBuilder alloc] init];

    self.messageView.text = [mb getPersonalizedMessageWithName:self.nameField.text];
}


@end
