//
//  mainViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 8/15/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "mainViewController.h"
#import "mainTableViewCell.h"

@interface mainViewController ()

@end

@implementation mainViewController
{
    
    
    NSMutableArray* data;
    
    UIViewController* signInViewController;
    
    //Used for when sending requests
    int hold;
    
    bool doesTokenWork;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    
    [self checkCredentials];
    
    doesTokenWork = false;
    
}

//This method is used to check if the user is on the device
-(void)checkCredentials
{

    //Load
    //  Username
    //  Password
    //  Token
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* password = [prefs stringForKey:@"password"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    
    //Save data
    /*[prefs setObject:userName forKey:@"userID"];
    [prefs setObject:password forKey:@"password"];
    [prefs setObject:token forKey:@"token"];*/
    
    NSLog(@"This is the username: %@", userName);
    if([userName  isEqual: @""])
    {
        //Needs to sign into account
        //Send to login view
        [self changeViewSignIn];
        
    }else{
        //Check token
        [self sendPost:userName withToken:token];
        
        
        if(doesTokenWork)
        {
            //Continue to main View
        }else{
            //Get new token by logging in
            //Continue to main View
        }
        
        
        
    }
    
    
    
    //Check if username exists
        //If it does
            //then try and log in and retrieve the token
            //then have it Initialsize View
        //Else
            //Send them to the account sign-in view
}

-(void)sendPost:(NSString*)username withToken:(NSString*)token
{
    NSString *post = [NSString stringWithFormat:@"username=%@&token=%@",username,token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://erhodes.oucreate.com/Cows/test.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@"%@",data);
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

-(void)checkIfTokenWorks:(NSString*)username withToken:(NSString*)token
{
    //Send request
    //If returns token then set doesTokenWork = true
    
    
    //TODO: Change to checking url
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/checkIfTokenWorks.php?username=%@&token=&@",username,token];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);//This works well in getting the data
        
        
        
        
        
    }] resume];
}


-(void)changeViewSignIn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    signInViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self addChildViewController:signInViewController];
    [self.view addSubview:signInViewController.view];
}


-(void)InitializeView
{
    //Loads the table view full of information on the recent activity on the account.
    //Loads the total number of cows
    //Loads the cost per month
    
}

//If the account button is pressed
- (IBAction)accountButtonPressed:(id)sender {
    
    
}

//Action button is pressed
- (IBAction)actionButtonPressed:(id)sender {
    NSLog(@"Test");
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    
    //Save data
    [prefs setObject:@"" forKey:@"userID"];
    [prefs setObject:@"" forKey:@"password"];
     [prefs setObject:@"" forKey:@"accessToken"];
}

//Manage herd button is pressed
- (IBAction)manageHerdButtonPressed:(id)sender {
    
}


//Expenses button is pressed
- (IBAction)expensesButtonPressed:(id)sender {
    
}



//If that cell is selected
//Needs to be able to take it to a window
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    //NSLog(@"%@", currentIndex);
    
    //This is how to access parent view controller!
    //This is used to get rid of the buttons while working with the view
    //[(RootViewController*)self.parentViewController hideButtons_side1];
    
    //Sets the current index
    //self->currentIndex = (int)indexPath.row;
    
    
    
    
    //Changes the view
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ExternalContent_Location_1" bundle:nil];
    
    extraViewController = [storyboard instantiateViewControllerWithIdentifier:@"CampaignPageViewController"];
    [self addChildViewController:extraViewController];
    [self.view addSubview:extraViewController.view];
    */
    
    //
    /*RootViewController *v = (RootViewController*)self.view.superclass;
     [v sendToOtherViewController];*/
    
    
    
    
    
    
    
}


//Gets the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 3;
}




//Adds the cell based on the data
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"mainTableViewCell";
    
    mainTableViewCell *cell = (mainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"mainTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.testlable.text = @"Test";
    //cell.weight.text = [weightData objectAtIndex:indexPath.row];
    
    //cell.title.text = [titleData objectAtIndex:indexPath.row];
   
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    // This is just Programatic method you can also do that by xib !
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end