//
//  RSAddNewUserViewController.m
//  Shipper
//
//  Created by QUIKHOP on 7/20/16.
//  Copyright © 2016 QUIKHOP. All rights reserved.
//

#import "RSAddNewUserViewController.h"
#import "RSMutipleSelectionTableViewCell.h"

@interface RSAddNewUserViewController ()
{
    BOOL tableShown;
    BOOL pTableShown;
    
    NSMutableArray *stateArr;
    NSString *stateId;
    
    __block NSArray *json;
    
    NSMutableArray *jobTypeArray;
    NSMutableArray *employementTypeArray;
    
    
    
    NSString *cityId;
    
    
    RSMutipleSelectionTableViewCell *checkCell;
    
    NSArray *regionArr;
    NSMutableArray *selectedRegionArray;
    NSMutableArray *storeRegionIndexArr;
    NSMutableArray *regnIdArray;
    
    NSArray *branchArr;
    NSMutableArray *selectedBranchArray;
    NSMutableArray *storeBranchIndexArr;
    
    
    NSArray *roleArr;
    NSMutableArray *selectedRoleArray;
    NSMutableArray *storeRoleIndexArr;
    
    NSArray *departmentArr;
    NSMutableArray *selectedDepartmentArray;
    NSMutableArray *storeDepartmentIndexArr;
    
    NSArray *functionalArray;
    NSMutableArray *selectedFunctionalArray;
    NSMutableArray *storeFunctionalIndexArr;
}

@end

@implementation RSAddNewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableShown  = false;
    pTableShown = false;
    stateArr      = [[NSMutableArray alloc]initWithCapacity:0];
    storeRegionIndexArr = [[NSMutableArray alloc]initWithCapacity:0];
    storeBranchIndexArr = [[NSMutableArray alloc]initWithCapacity:0];
    selectedRegionArray = [[NSMutableArray alloc]initWithCapacity:0];
    selectedBranchArray = [[NSMutableArray alloc]initWithCapacity:0];
    selectedRoleArray   = [[NSMutableArray alloc]initWithCapacity:0];
    storeRoleIndexArr   = [[NSMutableArray alloc]initWithCapacity:0];
    selectedDepartmentArray   = [[NSMutableArray alloc]initWithCapacity:0];
    storeDepartmentIndexArr   = [[NSMutableArray alloc]initWithCapacity:0];
    selectedFunctionalArray   = [[NSMutableArray alloc]initWithCapacity:0];
    storeFunctionalIndexArr   = [[NSMutableArray alloc]initWithCapacity:0];
    
    jobTypeArray  = [[NSMutableArray alloc]initWithObjects:@"Part Time",@"Full Type", nil];
    employementTypeArray = [[NSMutableArray alloc]initWithObjects:@"Company Payrole",@"Third Party", nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_rScrollView setContentSize:CGSizeMake(320, 1500)];
    
    [_rTableView setBackgroundColor:[UIColor whiteColor]];
    _rTableView.layer.cornerRadius = 5.0;
    _rTableView.layer.borderWidth = 1.0;
    _rTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [_pTableView setBackgroundColor:[UIColor whiteColor]];
    _pTableView.layer.cornerRadius = 5.0;
    _pTableView.layer.borderWidth = 1.0;
    _pTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self hitStateService];
    [self getAllRegion];
    [self getAllRole];
    [self getAllDepartment];
    [self setUserData];
}

#pragma mark set data of user to edit
-(void)setUserData
{
    if (_receiveDataDict != nil)
    {
        [_textFieldFName           setText:[Utils returnString:[_receiveDataDict objectForKey:@"firstName"]]];
        [_TextFieldMNmae           setText:[Utils returnString:[_receiveDataDict objectForKey:@"middleName"]]];
        [_TextFieldLname           setText:[Utils returnString:[_receiveDataDict objectForKey:@"lastName"]]];
        [_TextFieldMobNumber       setText:[Utils returnString:[_receiveDataDict objectForKey:@"mobileNumber"]]];
        [_TextFieldState           setText:[Utils returnString:[_receiveDataDict objectForKey:@"state"]]];
        stateId = [_receiveDataDict objectForKey:@"stateId"];
        [_TextFieldCity            setText:[Utils returnString:[_receiveDataDict objectForKey:@"city"]]];
        cityId = [_receiveDataDict objectForKey:@"cityId"];
        [_textFieldEmail           setText:[Utils returnString:[_receiveDataDict objectForKey:@"emailId"]]];
        [_textFieldPassword        setText:[Utils returnString:[_receiveDataDict objectForKey:@"userPassword"]]];
        [_textFieldPassword        setSecureTextEntry:YES];
        [_textFieldConfirlPassword setText:[Utils returnString:[_receiveDataDict objectForKey:@"userPassword"]]];
        [_textFieldConfirlPassword setSecureTextEntry:YES];
        [_textFieldAddress         setText:[Utils returnString:[_receiveDataDict objectForKey:@"address"]]];
        [_TextFieldJobType         setText:[Utils returnString:[_receiveDataDict objectForKey:@"jobType"]]];
        [_TextFieldEmpType         setText:[Utils returnString:[_receiveDataDict objectForKey:@"employementType"]]];
        [_TextFieldRegion          setText:[Utils returnString:[[[_receiveDataDict objectForKey:@"userRegion"]  valueForKey:@"regionName"] componentsJoinedByString:@","]]];
        [_TextFieldBranch          setText:[Utils returnString:[[[_receiveDataDict objectForKey:@"userBranch"]  valueForKey:@"branchName"] componentsJoinedByString:@","]]];
         [_TextFieldRole           setText:[Utils returnString:[[[_receiveDataDict objectForKey:@"userRole"]  valueForKey:@"roleName"] componentsJoinedByString:@","]]];
         [_TextFieldDepartment     setText:[Utils returnString:[[[_receiveDataDict objectForKey:@"userDepartment"]  valueForKey:@"departmentName"] componentsJoinedByString:@","]]];
         [_TextFieldFunctionalArea setText:[Utils returnString:[[[_receiveDataDict objectForKey:@"userFunctionalArea"]  valueForKey:@"functionalAreaName"] componentsJoinedByString:@","]]];
        
    }
}
# pragma mark get all state for load

-(void)hitStateService
{
    if (stateArr.count == 0)
    {
        [SVProgressHUD show];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [ stateArr addObjectsFromArray:[Utils getStateNameArray]];
           // [SVProgressHUD dismiss];
        });
    }
}

#pragma mark get all region
-(void)getAllRegion
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        regionArr = [[NSArray alloc]initWithArray:[Utils getAllRegionToShow]];
        if (_receiveDataDict != nil)
        {
            for (int i = 0; i<[[_receiveDataDict objectForKey:@"userRegion"] count]; i++)
            {
                NSString *regionName = [[[_receiveDataDict objectForKey:@"userRegion"] objectAtIndex:i] valueForKey:@"regionName"];
                int index = [[regionArr valueForKey:@"name"] indexOfObject:regionName];
                [storeRegionIndexArr addObject:[NSString stringWithFormat:@"%d",index]];
                [selectedRegionArray addObject:[regionArr objectAtIndex:index]];
            }
        }
        self.rTableView.backgroundColor = [UIColor whiteColor];
        [_pTableView reloadData];
        //[SVProgressHUD dismiss];
    });
}

#pragma mark get all region

-(void)getAllBranches
{
    if ([_TextFieldRegion.text isEqualToString:@""])
    {
        [Utils messageAlert:@"Select the region first!!!" title:INFO delegate:self];
        [_pTableView setHidden:YES];
        pTableShown = false;
    }
    else
    {
        [SVProgressHUD show];
        //NSArray *regnArr = [[NSArray alloc]initWithArray:[_TextFieldRegion.text componentsSeparatedByString:@","]];
        NSMutableArray *regionIdArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary *str in selectedRegionArray)
        {
            NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[str objectForKey:@"id"],@"RegionId", nil];
            [regionIdArr addObject:dict];
        }

        NSError *error;
        NSData * AjsonData = [NSJSONSerialization dataWithJSONObject:regionIdArr options:kNilOptions error:&error];
        __block NSString *Adatadict = [[NSString alloc] initWithData:AjsonData encoding:NSUTF8StringEncoding];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            branchArr = [[NSArray alloc]initWithArray:[Utils getBranchesOfRegion:Adatadict]];
            
            if (_receiveDataDict != nil)
            {
                for (int i = 0; i<[[_receiveDataDict objectForKey:@"userBranch"] count]; i++)
                {
                    NSString *regionName = [[[_receiveDataDict objectForKey:@"userBranch"] objectAtIndex:i] valueForKey:@"branchName"];
                    int index = [[branchArr valueForKey:@"name"] indexOfObject:regionName];
                    [storeBranchIndexArr addObject:[NSString stringWithFormat:@"%d",index]];
                    [selectedBranchArray addObject:[branchArr objectAtIndex:index]];
                }
            }
            self.pTableView.backgroundColor = [UIColor whiteColor];
            [_pTableView reloadData];
            [SVProgressHUD dismiss];
        });
    }

}

#pragma mark get all region

-(void)getAllFunctionalArea
{
    if ([_TextFieldDepartment.text isEqualToString:@""])
    {
        [Utils messageAlert:@"Select the department first!!!" title:INFO delegate:self];
        [_pTableView setHidden:YES];
        pTableShown = false;
    }
    else
    {
        [SVProgressHUD show];
        //NSArray *regnArr = [[NSArray alloc]initWithArray:[_TextFieldRegion.text componentsSeparatedByString:@","]];
        NSMutableArray *regionIdArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary *str in selectedDepartmentArray)
        {
            NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[str objectForKey:@"id"],@"DepartmentId", nil];
            [regionIdArr addObject:dict];
        }
        
        NSError *error;
        NSData * AjsonData = [NSJSONSerialization dataWithJSONObject:regionIdArr options:kNilOptions error:&error];
        __block NSString *Adatadict = [[NSString alloc] initWithData:AjsonData encoding:NSUTF8StringEncoding];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            functionalArray = [[NSArray alloc]initWithArray:[Utils getFunctioalAreaOfDepartment:Adatadict]];
            
            if (_receiveDataDict != nil)
            {
                for (int i = 0; i<[[_receiveDataDict objectForKey:@"userFunctionalArea"] count]; i++)
                {
                    NSString *regionName = [[[_receiveDataDict objectForKey:@"userFunctionalArea"] objectAtIndex:i] valueForKey:@"functionalAreaName"];
                    int index = [[functionalArray valueForKey:@"name"] indexOfObject:regionName];
                    [storeFunctionalIndexArr addObject:[NSString stringWithFormat:@"%d",index]];
                    [selectedFunctionalArray addObject:[functionalArray objectAtIndex:index]];
                }
            }
            
            self.pTableView.backgroundColor = [UIColor whiteColor];
            [_pTableView reloadData];
            [SVProgressHUD dismiss];
        });
    }
    
}

#pragma mark get all region

-(void)getAllRole
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        roleArr = [[NSArray alloc]initWithArray:[Utils getAllRoleToShow]];
        
        if (_receiveDataDict != nil)
        {
            for (int i = 0; i<[[_receiveDataDict objectForKey:@"userRole"] count]; i++)
            {
                NSString *regionName = [[[_receiveDataDict objectForKey:@"userRole"] objectAtIndex:i] valueForKey:@"roleName"];
                int index = [[roleArr valueForKey:@"name"] indexOfObject:regionName];
                [storeRoleIndexArr addObject:[NSString stringWithFormat:@"%d",index]];
            }
        }
        self.rTableView.backgroundColor = [UIColor whiteColor];
        [_rTableView reloadData];
        //[SVProgressHUD dismiss];
    });
}

-(void)getAllDepartment
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        departmentArr = [[NSArray alloc]initWithArray:[Utils getAllDepartmentToShow]];
        if (_receiveDataDict != nil)
        {
            for (int i = 0; i<[[_receiveDataDict objectForKey:@"userDepartment"] count]; i++)
            {
                NSString *regionName = [[[_receiveDataDict objectForKey:@"userDepartment"] objectAtIndex:i] valueForKey:@"departmentName"];
                int index = [[departmentArr valueForKey:@"name"] indexOfObject:regionName];
                [storeDepartmentIndexArr addObject:[NSString stringWithFormat:@"%d",index]];
                [selectedDepartmentArray addObject:[departmentArr objectAtIndex:index]];
            }
        }

        [SVProgressHUD dismiss];
    });
}
#pragma mark table view data sourc method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _rTableView)
    {
        if (_rTableView.tag == 1)
        {
             return [[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] count];
        }
        else if(_rTableView.tag ==2)
        {
             return [[json valueForKey:@"city"] count];
        }
        else if(_rTableView.tag == 3)
        {
            return jobTypeArray.count;
        }
        else
        {
            return employementTypeArray.count;
        }
    }
    else
    {
        if (_pTableView.tag == 1)
        {
            return regionArr.count;
        }
        else if (_pTableView.tag == 2)
        {
            return branchArr.count;
        }
        else if (_pTableView.tag == 3)
        {
            return roleArr.count;
        }
        else if (_pTableView.tag == 4)
        {
            return departmentArr.count;
        }
        else
        {
            return functionalArray.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _rTableView)
    {
       UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Ranjit Singh"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_rTableView.tag == 1)
        {
            [cell.textLabel setText:[[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
            stateId =[[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"id"] objectAtIndex:indexPath.row];
            
        }
        else if(_rTableView.tag ==2)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.textLabel setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
            cityId = [[json objectAtIndex:indexPath.row] valueForKey:@"city_ID"];
        }
        else if(_rTableView.tag == 3)
        {
            [cell.textLabel setText:[jobTypeArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [cell.textLabel setText:[employementTypeArray objectAtIndex:indexPath.row]];

        }
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        
        return cell;
         
    }
    else
    {
        checkCell = [tableView dequeueReusableCellWithIdentifier:@"RSMutipleSelectionTableViewCell" forIndexPath:indexPath];
         checkCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_pTableView.tag == 1)
        {
            if (![storeRegionIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
    
            }
            else
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            }
            
            [checkCell.btnCheck setTag:indexPath.row];
            [checkCell.labelName setText:[[regionArr valueForKey:@"name"] objectAtIndex:indexPath.row]];
            
            [checkCell.btnCheck addTarget:self action:@selector(checkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (_pTableView.tag == 2)
        {
            if (![storeBranchIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            }
            
            [checkCell.btnCheck setTag:indexPath.row];
            [checkCell.labelName setText:[[branchArr valueForKey:@"name"] objectAtIndex:indexPath.row]];
            
            [checkCell.btnCheck addTarget:self action:@selector(checkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (_pTableView.tag == 3)
        {
            
            if (![storeRoleIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            }
            
            [checkCell.btnCheck setTag:indexPath.row];
            [checkCell.labelName setText:[[roleArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            [checkCell.btnCheck addTarget:self action:@selector(checkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

        }
        else if (_pTableView.tag == 4)
        {
            
            if (![storeDepartmentIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            }
            
            [checkCell.btnCheck setTag:indexPath.row];
            [checkCell.labelName setText:[[departmentArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            [checkCell.btnCheck addTarget:self action:@selector(checkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        else
        {
            if (![storeFunctionalIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            }
            
            [checkCell.btnCheck setTag:indexPath.row];
            [checkCell.labelName setText:[[functionalArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
            
            [checkCell.btnCheck addTarget:self action:@selector(checkBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

        }
        return checkCell;
    }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _rTableView)
    {
        if (_rTableView.tag == 1)
        {
            [_TextFieldState setText:[[[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"stateData"]] valueForKey:@"stateName"] objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            [_TextFieldCity setText:@""];
            tableShown = false;
        }
        if (_rTableView.tag == 2)
        {
            [_TextFieldCity setText:[[json valueForKey:@"city"] objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        if (_rTableView.tag == 3)
        {
            [_TextFieldJobType setText:[jobTypeArray objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
        if (_rTableView.tag == 4)
        {
            [_TextFieldEmpType setText:[employementTypeArray objectAtIndex:indexPath.row]];
            [_rTableView setHidden:YES];
            tableShown = false;
        }
    }
   
}

-(void)checkBtnPressed:(UIButton *)sender
{
    if (_pTableView.tag == 1)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_pTableView];
        NSIndexPath *aIndexPath = [_pTableView indexPathForRowAtPoint:buttonPosition];
        checkCell = (RSMutipleSelectionTableViewCell *)[_pTableView cellForRowAtIndexPath:aIndexPath];
        if ([storeRegionIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]])
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
            [storeRegionIndexArr removeObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedRegionArray removeObject:[regionArr  objectAtIndex:(long)aIndexPath.row]];
        }
        else
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            [storeRegionIndexArr addObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedRegionArray addObject:[regionArr  objectAtIndex:(long)aIndexPath.row]];
        }
        NSLog(@"the selected city is = %@",selectedRegionArray);
      //  NSString *cityStr = [selectedRegionArray componentsJoinedByString:@","];
      //  NSLog(@"the selected city is = %@",cityStr);
        
        [_TextFieldRegion setText:[NSString stringWithFormat:@"%@",[[selectedRegionArray valueForKey:@"name"] componentsJoinedByString:@","]]];
    }
    else if (_pTableView.tag == 2)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_pTableView];
        NSIndexPath *aIndexPath = [_pTableView indexPathForRowAtPoint:buttonPosition];
        checkCell = (RSMutipleSelectionTableViewCell *)[_pTableView cellForRowAtIndexPath:aIndexPath];
        if ([storeBranchIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]])
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
            [storeBranchIndexArr removeObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedBranchArray removeObject:[branchArr  objectAtIndex:(long)aIndexPath.row]];
        }
        else
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            [storeBranchIndexArr addObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedBranchArray addObject:[branchArr  objectAtIndex:(long)aIndexPath.row]];
        }
        NSLog(@"the selected city is = %@",selectedBranchArray);
//        NSString *cityStr = [[selectedBranchArray valueForKey:@"name"] componentsJoinedByString:@","];
//        NSLog(@"the selected city is = %@",cityStr);
        [_TextFieldBranch setText:[NSString stringWithFormat:@"%@",[[selectedBranchArray valueForKey:@"name"] componentsJoinedByString:@","]]];
 
    }
    else if (_pTableView.tag == 3)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_pTableView];
        NSIndexPath *aIndexPath = [_pTableView indexPathForRowAtPoint:buttonPosition];
        checkCell = (RSMutipleSelectionTableViewCell *)[_pTableView cellForRowAtIndexPath:aIndexPath];
        if ([storeRoleIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]])
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
            [storeRoleIndexArr removeObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedRoleArray removeObject:[roleArr  objectAtIndex:(long)aIndexPath.row]];
        }
        else
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            [storeRoleIndexArr addObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedRoleArray addObject:[roleArr  objectAtIndex:(long)aIndexPath.row]];
        }
        NSLog(@"the selected city is = %@",selectedRoleArray);
        //        NSString *cityStr = [[selectedBranchArray valueForKey:@"name"] componentsJoinedByString:@","];
        //        NSLog(@"the selected city is = %@",cityStr);
        [_TextFieldRole setText:[NSString stringWithFormat:@"%@",[[selectedRoleArray valueForKey:@"name"] componentsJoinedByString:@","]]];
    }
    else if (_pTableView.tag == 4)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_pTableView];
        NSIndexPath *aIndexPath = [_pTableView indexPathForRowAtPoint:buttonPosition];
        checkCell = (RSMutipleSelectionTableViewCell *)[_pTableView cellForRowAtIndexPath:aIndexPath];
        if ([storeDepartmentIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]])
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
            [storeDepartmentIndexArr removeObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedDepartmentArray removeObject:[departmentArr  objectAtIndex:(long)aIndexPath.row]];
        }
        else
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            [storeDepartmentIndexArr addObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedDepartmentArray addObject:[departmentArr  objectAtIndex:(long)aIndexPath.row]];
        }
        NSLog(@"the selected city is = %@",selectedRoleArray);
        //        NSString *cityStr = [[selectedBranchArray valueForKey:@"name"] componentsJoinedByString:@","];
        //        NSLog(@"the selected city is = %@",cityStr);
        [_TextFieldDepartment setText:[NSString stringWithFormat:@"%@",[[selectedDepartmentArray valueForKey:@"name"] componentsJoinedByString:@","]]];
    }
    else
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_pTableView];
        NSIndexPath *aIndexPath = [_pTableView indexPathForRowAtPoint:buttonPosition];
        checkCell = (RSMutipleSelectionTableViewCell *)[_pTableView cellForRowAtIndexPath:aIndexPath];
        if ([storeFunctionalIndexArr containsObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]])
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FUnchecked.png"] forState:UIControlStateNormal];
            [storeFunctionalIndexArr removeObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedFunctionalArray removeObject:[functionalArray  objectAtIndex:(long)aIndexPath.row]];
        }
        else
        {
            [checkCell.btnCheck setImage:[UIImage imageNamed:@"FChecked.png"] forState:UIControlStateNormal];
            [storeFunctionalIndexArr addObject:[NSString stringWithFormat:@"%ld",(long)aIndexPath.row]];
            [selectedFunctionalArray addObject:[functionalArray  objectAtIndex:(long)aIndexPath.row]];
        }
        NSLog(@"the selected city is = %@",selectedRoleArray);
        //        NSString *cityStr = [[selectedBranchArray valueForKey:@"name"] componentsJoinedByString:@","];
        //        NSLog(@"the selected city is = %@",cityStr);
        [_TextFieldFunctionalArea setText:[NSString stringWithFormat:@"%@",[[selectedFunctionalArray valueForKey:@"name"] componentsJoinedByString:@","]]];
    }

}
#pragma mark button actions for single selection

- (IBAction)btnStatePressed:(id)sender
{
    [_rTableView setTag:1];
    if (_btnState.tag == 1)
    {
        _btnState.tag          = 2;
        _btnCity.tag           = 1;
        _btnJobType.tag        = 1;
        _btnEmpType.tag        = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        [_rTableView reloadData];
        [self setFrameForState];
    }
    else
    {
        [self showtableView:tableShown];
        [_rTableView reloadData];
        [self setFrameForState];
    }
}

- (IBAction)btnCityPressed:(id)sender
{
    [_rTableView setTag:2];
    
    if (_btnCity.tag == 1)
    {
        _btnCity.tag           = 2;
        _btnState.tag          = 1;
        _btnJobType.tag        = 1;
        _btnEmpType.tag        = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        
        
        [self setFrameForCity];
    }
    else
    {
        [self showtableView:tableShown];
        [self setFrameForCity];
    }
    
    [self hitCityService:_TextFieldState.text];
}
- (IBAction)btnJobTypePressed:(id)sender
{
    [_rTableView setTag:3];
    
    if (_btnJobType.tag == 1)
    {
        _btnJobType.tag        = 2;
        _btnState.tag          = 1;
        _btnCity.tag           = 1;
        _btnEmpType.tag        = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        [_rTableView reloadData];
        
        [self setFrameForJobType];
    }
    else
    {
        [self showtableView:tableShown];
        [self setFrameForJobType];
        [_rTableView reloadData];
    }
}
- (IBAction)btnEmpTypePressed:(id)sender
{
    [_rTableView setTag:4];
    
    if (_btnEmpType.tag == 1)
    {
        _btnEmpType.tag        = 2;
        _btnState.tag          = 1;
        _btnCity.tag           = 1;
        _btnJobType.tag        = 1;
        
        [_rTableView setHidden:NO];
        tableShown = true;
        [_rTableView reloadData];
        [self setFrameForEmployement];
    }
    else
    {
        [self showtableView:tableShown];
        [self setFrameForEmployement];
        [_rTableView reloadData];
    }

}

#pragma mark button actions for multiple selection

- (IBAction)btnRegionPressed:(id)sender
{
    [_pTableView setTag:1];
    
    if (_btnRegion.tag == 1)
    {
        _btnRegion.tag        = 2;
        _btnBranch.tag        = 1;
        _btnRole.tag          = 1;
        _btnDepartment.tag    = 1;
        _btnFunctionalArea.tag        = 1;
        
        [_pTableView setHidden:NO];
        pTableShown = true;
        [_pTableView reloadData];
        [self setFrameForRegion];
    }
    else
    {
        [self pShowtableView:pTableShown];
        [self setFrameForRegion];
        [_pTableView reloadData];
    }
  
}
- (IBAction)btnBranchPressed:(id)sender
{
    [_pTableView setTag:2];
    
    if (_btnBranch.tag == 1)
    {
        _btnBranch.tag        = 2;
        _btnRegion.tag        = 1;
        _btnRole.tag          = 1;
        _btnDepartment.tag    = 1;
        _btnFunctionalArea.tag        = 1;

        
        [_pTableView setHidden:NO];
        pTableShown = true;
        [self setFrameForBranch];
    }
    else
    {
        [self pShowtableView:pTableShown];
        [self setFrameForBranch];
    }
    [self getAllBranches];
  
}
- (IBAction)btnRolePressed:(id)sender
{
    [_pTableView setTag:3];
    
    if (_btnRole.tag == 1)
    {
        _btnRole.tag        = 2;
        _btnRegion.tag        = 1;
        _btnBranch.tag          = 1;
        _btnDepartment.tag    = 1;
        _btnFunctionalArea.tag        = 1;
        
        [_pTableView setHidden:NO];
        pTableShown = true;
        [_pTableView reloadData];
        [self setFrameForRole];
    }
    else
    {
        [self pShowtableView:pTableShown];
        [self setFrameForRole];
        [_pTableView reloadData];
    }

}
- (IBAction)btnDepartmentPressed:(id)sender
{
    [_pTableView setTag:4];
    
    if (_btnDepartment.tag == 1)
    {
        _btnDepartment.tag        = 2;
        _btnRegion.tag        = 1;
        _btnRole.tag          = 1;
        _btnBranch.tag    = 1;
        _btnFunctionalArea.tag        = 1;
        
        [_pTableView setHidden:NO];
        pTableShown = true;
        [_pTableView reloadData];
        [self setFrameForDepartment];
    }
    else
    {
        [self pShowtableView:pTableShown];
        [_pTableView reloadData];
        [self setFrameForDepartment];
    }
}
- (IBAction)btnFunctionalAreaPressed:(id)sender
{
    [_pTableView setTag:5];
    
    if (_btnFunctionalArea.tag == 1)
    {
        _btnFunctionalArea.tag        = 2;
        _btnRegion.tag        = 1;
        _btnRole.tag          = 1;
        _btnDepartment.tag    = 1;
        _btnBranch.tag        = 1;
        
        [_pTableView setHidden:NO];
        pTableShown = true;
        [self setFrameForFunctionalArea];
    }
    else
    {
        [self pShowtableView:pTableShown];
        [self setFrameForFunctionalArea];
    }
    [self getAllFunctionalArea];
}

#pragma mark control btn actions

- (IBAction)submitBtnPressed:(id)sender
{
    if ([_textFieldFName.text isEqualToString:@""]||[_TextFieldLname.text isEqualToString:@""]||[_TextFieldMobNumber.text isEqualToString:@""]||[_TextFieldState.text isEqualToString:@""]||[_TextFieldCity.text isEqualToString:@""]||[_textFieldEmail.text isEqualToString:@""]||[_textFieldPassword.text isEqualToString:@""]||[_textFieldConfirlPassword.text isEqualToString:@""]||[_textFieldAddress.text isEqualToString:@""]||[_TextFieldJobType.text isEqualToString:@""]||[_TextFieldEmpType.text isEqualToString:@""]||[_TextFieldRegion.text isEqualToString:@""]||[_TextFieldBranch.text isEqualToString:@""]||[_TextFieldRole.text isEqualToString:@""]||[_TextFieldDepartment.text isEqualToString:@""]||[_TextFieldFunctionalArea.text isEqualToString:@""])
    {
        [Utils messageAlert:FILL_ALL_DATA title:INFO delegate:self];
    }
    else
    {
        if (![Utils validMobile:_TextFieldMobNumber.text])
        {
            [Utils messageAlert:VALID_MOBILE title:INFO delegate:self];
        }
        else
        {
            if (![Utils validateEmail:_textFieldEmail.text])
            {
                [Utils messageAlert:CHECK_EMAIL_VALIDITY title:INFO delegate:self];
                
            }
            else
            {
                if ([_textFieldPassword.text length] <8)
                {
                    [Utils messageAlert:VALIDATE_PASSWORD title:INFO delegate:self];
                }
                else
                {
                    if (![_textFieldPassword.text isEqualToString:_textFieldConfirlPassword.text])
                    {
                        [Utils messageAlert:PAS_MIS_MATCH title:INFO delegate:self];
                    }
                    else
                    {
//                        if (_receiveDataDict != nil)
//                        {
//                            [self updateUser];
//                        }
//                        else
//                        {
                            [self createNewUser];
 //                       }
                    }
                }
            }
        }
    }
}

#pragma mark update user

-(void)updateUser
{
    
}
#pragma mark create new user
-(void)createNewUser
{
    [SVProgressHUD show];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        NSDictionary *successDict = [[NSDictionary alloc]initWithDictionary:[Utils createNewUser:[self createJsonOfUser]]];
         NSLog(@"%@",successDict);
        if (!([successDict objectForKey:@"message"] == [NSNull null]))
        {
            [Utils messageAlert:[successDict objectForKey:@"message"] title:INFO delegate:self];
        }
        else
        {
            if ([[[successDict objectForKey:@"accountUser"] allKeys] containsObject:@"id"])
            {
                [Utils messageAlert:@"User added successfully!!!" title:INFO delegate:self];
                [self.view endEditing:YES];
                [_textFieldFName           setText:@""];
                [_TextFieldMNmae           setText:@""];
                [_TextFieldLname           setText:@""];
                [_TextFieldMobNumber       setText:@""];
                [_TextFieldState           setText:@""];
                [_TextFieldCity            setText:@""];
                [_textFieldEmail           setText:@""];
                [_textFieldPassword        setText:@""];
                [_textFieldConfirlPassword setText:@""];
                [_textFieldAddress         setText:@""];
                [_TextFieldJobType         setText:@""];
                [_TextFieldEmpType         setText:@""];
                [_TextFieldRegion          setText:@""];
                [_TextFieldBranch          setText:@""];
                [_TextFieldRole            setText:@""];
                [_TextFieldDepartment      setText:@""];
                [_TextFieldFunctionalArea  setText:@""];
            }
            else
            {
              [Utils messageAlert:[successDict objectForKey:@"message"] title:INFO delegate:self];  
            }

        }
       
        [SVProgressHUD dismiss];
    });
}
#pragma mark create json to post for new user
-(NSString *)createJsonOfUser
{
    NSDictionary *logDict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]];
    
    // region dictionay
    
    NSMutableArray *regnArrayToPost = [[NSMutableArray alloc]init];
    for (int i = 0;i<selectedRegionArray.count;i++)
    {
        NSMutableDictionary *regDict = [[NSMutableDictionary alloc]init];
        NSDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[selectedRegionArray objectAtIndex:i]];
        [regDict setObject:[dic objectForKey:@"id"] forKey:@"RegionId"];
        [regDict setObject:[dic objectForKey:@"name"] forKey:@"RegionName"];
        [regDict setObject:[logDict objectForKey:@"subscriptionId"] forKey:@"SubscriptionId"];
        [regDict setObject:@"" forKey:@"IPAddress"];
        [regDict setObject:@"" forKey:@"SourceBrowser"];
        [regDict setObject:[dic objectForKey:@"createdBy"] forKey:@"CreatedBY"];
        [regDict setObject:@"" forKey:@"SourceDecice"];
        if (_receiveDataDict != nil)
        {
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userRegion"] objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userRegion"] objectAtIndex:i] objectForKey:@"rowVersion"] forKey:@"RowVersion"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userRegion"] objectAtIndex:i] objectForKey:@"createdDate"] forKey:@"CreatedDate"];
            
        }
        [regnArrayToPost addObject:regDict];
    }
    
    // branch dictionay
    
    NSMutableArray *branchArrayToPost = [[NSMutableArray alloc]init];
    for (int i = 0;i<selectedBranchArray.count;i++)
    {
        NSDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[selectedBranchArray objectAtIndex:i]];
        NSMutableDictionary *regDict = [[NSMutableDictionary alloc]init];
        [regDict setObject:[dic objectForKey:@"id"] forKey:@"BranchId"];
        [regDict setObject:[dic objectForKey:@"name"] forKey:@"BranchName"];
        [regDict setObject:[logDict objectForKey:@"subscriptionId"] forKey:@"SubscriptionId"];
        [regDict setObject:@"" forKey:@"IPAddress"];
        [regDict setObject:@"" forKey:@"SourceBrowser"];
        [regDict setObject:[dic objectForKey:@"createdBy"] forKey:@"CreatedBY"];
        [regDict setObject:@"" forKey:@"SourceDecice"];
        if (_receiveDataDict != nil)
        {
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userBranch"] objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userBranch"] objectAtIndex:i] objectForKey:@"rowVersion"] forKey:@"RowVersion"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userBranch"] objectAtIndex:i] objectForKey:@"createdDate"] forKey:@"CreatedDate"];
            
        }
        [branchArrayToPost addObject:regDict];
    }
    // role dictionay
    
    NSMutableArray *roleArrayToPost = [[NSMutableArray alloc]init];
    for (int i = 0;i<selectedRoleArray.count;i++)
    {
        NSDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[selectedRoleArray objectAtIndex:i]];
        NSMutableDictionary *regDict = [[NSMutableDictionary alloc]init];
        [regDict setObject:[dic objectForKey:@"id"] forKey:@"RoleId"];
        [regDict setObject:[dic objectForKey:@"name"] forKey:@"RoleName"];
        [regDict setObject:[logDict objectForKey:@"subscriptionId"] forKey:@"SubscriptionId"];
        [regDict setObject:@"" forKey:@"IPAddress"];
        [regDict setObject:@"" forKey:@"SourceBrowser"];
        [regDict setObject:[dic objectForKey:@"createdBy"] forKey:@"CreatedBY"];
        [regDict setObject:@"" forKey:@"SourceDecice"];
        if (_receiveDataDict != nil)
        {
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userRole"] objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userRole"] objectAtIndex:i] objectForKey:@"rowVersion"] forKey:@"RowVersion"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userRole"] objectAtIndex:i] objectForKey:@"createdDate"] forKey:@"CreatedDate"];
            
        }
        [roleArrayToPost addObject:regDict];
    }
    
    // UserDepartment dictionay
    
    NSMutableArray *departmentArrayToPost = [[NSMutableArray alloc]init];
    for (int i = 0;i<selectedDepartmentArray.count;i++)
    {
        NSDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[selectedDepartmentArray objectAtIndex:i]];
        NSMutableDictionary *regDict = [[NSMutableDictionary alloc]init];
        [regDict setObject:[dic objectForKey:@"id"] forKey:@"DepartmentId"];
        [regDict setObject:[dic objectForKey:@"name"] forKey:@"DepartmentName"];
        [regDict setObject:[logDict objectForKey:@"subscriptionId"] forKey:@"SubscriptionId"];
        [regDict setObject:@"" forKey:@"IPAddress"];
        [regDict setObject:@"" forKey:@"SourceBrowser"];
        [regDict setObject:[dic objectForKey:@"createdBy"] forKey:@"CreatedBY"];
        [regDict setObject:@"" forKey:@"SourceDecice"];
        if (_receiveDataDict != nil)
        {
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userDepartment"] objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userDepartment"] objectAtIndex:i] objectForKey:@"rowVersion"] forKey:@"RowVersion"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userDepartment"] objectAtIndex:i] objectForKey:@"createdDate"] forKey:@"CreatedDate"];
            
        }
        [departmentArrayToPost addObject:regDict];
    }
    
    
    // UserFunctionalArea dictionay
    
    NSMutableArray *functionalArrayToPost = [[NSMutableArray alloc]init];
    for (int i = 0;i<selectedFunctionalArray.count;i++)
    {
        NSDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[selectedFunctionalArray objectAtIndex:i]];        NSMutableDictionary *regDict = [[NSMutableDictionary alloc]init];
        [regDict setObject:[dic objectForKey:@"departmentMasterId"] forKey:@"DepartmentId"];
        [regDict setObject:[dic objectForKey:@"id"] forKey:@"FunctionalAreaId"];
        [regDict setObject:[dic objectForKey:@"name"] forKey:@"FunctionalAreaName"];
        [regDict setObject:[logDict objectForKey:@"subscriptionId"] forKey:@"SubscriptionId"];
        [regDict setObject:@"" forKey:@"IPAddress"];
        [regDict setObject:@"" forKey:@"SourceBrowser"];
        [regDict setObject:[dic objectForKey:@"createdBy"] forKey:@"CreatedBY"];
        [regDict setObject:@"" forKey:@"SourceDecice"];
        if (_receiveDataDict != nil)
        {
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userFunctionalArea"] objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userFunctionalArea"] objectAtIndex:i] objectForKey:@"rowVersion"] forKey:@"RowVersion"];
            [regDict setObject:[[[_receiveDataDict valueForKey:@"userFunctionalArea"] objectAtIndex:i] objectForKey:@"createdDate"] forKey:@"CreatedDate"];
            
        }
        [functionalArrayToPost addObject:regDict];
    }
    
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc]init];
    
    [userDict setObject:_textFieldFName.text forKey:@"FirstName"];
    [userDict setObject:_TextFieldMNmae.text forKey:@"MiddleName"];
    [userDict setObject:_TextFieldLname.text forKey:@"LastName"];
    [userDict setObject:_TextFieldMobNumber.text forKey:@"MobileNumber"];
    [userDict setObject:_textFieldEmail.text forKey:@"EmailId"];
    [userDict setObject:_textFieldPassword.text forKey:@"UserPassword"];
    [userDict setObject:_TextFieldJobType.text forKey:@"JobType"];
    [userDict setObject:_TextFieldEmpType.text forKey:@"EmployementType"];
    [userDict setObject:stateId                forKey:@"StateId"];
    [userDict setObject:_TextFieldState.text forKey:@"State"];
    [userDict setObject:cityId forKey:@"CityId"];
    [userDict setObject:_TextFieldCity.text forKey:@"City"];
    [userDict setObject:_textFieldAddress.text forKey:@"Address"];
    [userDict setObject:[logDict objectForKey:@"firstTimeLogin"] forKey:@"FirstTimeLogin"];
    
    [userDict setObject:[logDict objectForKey:@"subscriptionId"] forKey:@"SubscriptionId"];
    [userDict setObject:@"" forKey:@"IPAddress"];
    if (_receiveDataDict !=nil)
    {
        [userDict setObject:[_receiveDataDict objectForKey:@"updatedBy"] forKey:@"UpdatedBy"];
        [userDict setObject:[_receiveDataDict objectForKey:@"rowVersion"] forKey:@"RowVersion"];
        [userDict setObject:[_receiveDataDict objectForKey:@"id"] forKey:@"Id"];
        [userDict setObject:[_receiveDataDict objectForKey:@"createdDate"] forKey:@"CreatedDate"];
    }
    [userDict setObject:@"" forKey:@"SourceBrowser"];
    [userDict setObject:[logDict objectForKey:@"emailId"] forKey:@"CreatedBY"];
    [userDict setObject:@"" forKey:@"SourceDecice"];
    [userDict setObject:[logDict objectForKey:@"subscriptionType"] forKey:@"SubscriptionType"];
    [userDict setObject:@"false" forKey:@"IsSubscriber"];
    
    [userDict setValue:regnArrayToPost forKey:@"UserRegion"];
    [userDict setValue:branchArrayToPost forKey:@"UserBranch"];
    [userDict setValue:roleArrayToPost forKey:@"UserRole"];
    [userDict setValue:departmentArrayToPost forKey:@"UserDepartment"];
    [userDict setValue:functionalArrayToPost forKey:@"UserFunctionalArea"];

    
    NSError *wholeError;
    NSData *wholeJsonData = [NSJSONSerialization dataWithJSONObject:userDict options:NSJSONWritingPrettyPrinted error:&wholeError];
    NSString *wholeDatadict = [[NSString alloc] initWithData:wholeJsonData encoding:NSUTF8StringEncoding];
    
    NSString *userUpdate = [NSString stringWithFormat:@"{\"AccountUser\":%@}",wholeDatadict];
    NSLog(@"%@",userUpdate);
    
    return userUpdate;
}
- (IBAction)cancelBtnPressed:(id)sender
{
    
}

#pragma handling visibility of date picker

-(BOOL)showtableView :(BOOL)passIsShown
{
    if (tableShown == true)
    {
        [_rTableView setHidden:YES];
        tableShown  = false;
    }
    else
    {
        [_rTableView setHidden:NO];
        tableShown  = true;
    }
    return tableShown;
}

#pragma handling visibility of date picker

-(BOOL)pShowtableView :(BOOL)passIsShown
{
    if (pTableShown == true)
    {
        [_pTableView setHidden:YES];
        pTableShown  = false;
    }
    else
    {
        [_pTableView setHidden:NO];
        pTableShown  = true;
    }
    return pTableShown;
}
#pragma mark set frame of table view of single selection

-(void)setFrameForState
{
    [_rTableView setFrame:CGRectMake(8, 192, 304, 200)];
}
-(void)setFrameForCity
{
    [_rTableView setFrame:CGRectMake(8, 231, 304, 200)];
}
-(void)setFrameForJobType
{
    [_rTableView setFrame:CGRectMake(8, 420, 304, 50)];
}
-(void)setFrameForEmployement
{
    [_rTableView setFrame:CGRectMake(8, 457, 304, 50)];
}

#pragma mark set frame of table view of multiple selection
-(void)setFrameForFunctionalArea
{
    [_pTableView setFrame:CGRectMake(8, 648, 304, 200)];
}
-(void)setFrameForDepartment
{
    [_pTableView setFrame:CGRectMake(8, 611, 304, 200)];
}
-(void)setFrameForRole
{
    [_pTableView setFrame:CGRectMake(8, 573, 304, 200)];
}
-(void)setFrameForBranch
{
    [_pTableView setFrame:CGRectMake(8, 535, 304, 200)];
}
-(void)setFrameForRegion
{
    [_pTableView setFrame:CGRectMake(8, 496, 304, 200)];
}

#pragma mark hitservice to fetch state name

-(void)hitCityService:(NSString *)stateName
{
    if ([_TextFieldState.text isEqualToString:@""])
    {
        [Utils messageAlert:@"Select state first!!!" title:INFO delegate:self];
        [_rTableView setHidden:YES];
        tableShown = false;
    }
    else
    {
        NSString *completeLoginUrlWithSpace = [NSString stringWithFormat:@"%@%@?state=%@",DOMAIN_URL,CITY_LIST,stateName];
        NSString* completeLoginUrl = [completeLoginUrlWithSpace stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [SVProgressHUD show];
        
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:completeLoginUrl]];
        
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json"       forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             
             if (data != nil)
             {
                 id rsJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
                 json = [[NSArray alloc]initWithArray:rsJson];
                 
                 if (json != nil)
                 {
                     [_rTableView reloadData];
                 }
                 [SVProgressHUD dismiss];
             }
             else
             {
                 [SVProgressHUD dismiss];
             }
         }];
  
    }
    
}

#pragma mark set full width of separator
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)rCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([rCell respondsToSelector:@selector(setSeparatorInset:)]) {
        [rCell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([rCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [rCell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.rTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.rTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.rTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.rTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([self.pTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.pTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.pTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.pTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
