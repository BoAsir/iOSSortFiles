//
//  ViewController.m
//  sortDemo
//
//  Created by 路飞  on 2018/7/27.
//  Copyright © 2018年 lufei. All rights reserved.
//

#import "ViewController.h"
#import "KKLocalHotCityTableViewCell.h"
#import "KKLocalHotCollectionViewCell.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
//views
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* localBtn;
//datas
@property (nonatomic, strong) NSArray* dataArr;
@property (nonatomic, strong) NSMutableArray* dataNameArr;
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initNav];
    [self initViews];
    [self initLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private
-(void)initDatas{
    self.dataArr = @[@{@"name":@"热门",@"array":@[@"北京", @"杭州", @"上海", @"重庆", @"成都", @"武汉"]},
                     @{@"name":@"A",@"array":@[@"安康",@"阿克苏",@"阿勒泰",@"澳门",@"安庆",@"鞍山",@"安顺",@"阿图什",@"安阳"]},
                     @{@"name":@"B",@"array":@[@"蚌埠", @"白城", @"保定", @"北海", @"北京", @"宝鸡", @"毕节", @"博乐", @"白山", @"保山", @"百色", @"包头", @"本溪", @"白银", @"巴彦淖尔", @"滨州", @"巴中"]},
                     @{@"name":@"C",@"array":@[@"承德", @"成都", @"常德", @"赤峰", @"巢湖", @"昌吉", @"朝阳", @"长春", @"长沙", @"常州", @"潮州", @"沧州", @"滁州", @"池州", @"郴州", @"崇左"]},
                     @{@"name":@"D",@"array":@[@"丹东", @"东莞", @"大连", @"大庆", @"大同", @"定西", @"东营", @"德阳", @"都匀", @"德州", @"达州"]},
                     @{@"name":@"E",@"array":@[@"鄂尔多斯", @"二连浩特", @"恩施", @"鄂州"]},
                     @{@"name":@"F",@"array":@[@"防城港", @"佛山", @"抚顺", @"阜新", @"阜阳", @"抚州", @"福州"]},
                     @{@"name":@"G",@"array":@[@"贵港", @"桂林", @"高雄", @"固原", @"广元", @"贵阳", @"广州", @"赣州"]},
                     @{@"name":@"H",@"array":@[@"淮安", @"淮北", @"鹤壁", @"河池", @"邯郸", @"哈尔滨", @"合肥", @"鹤岗", @"黄冈", @"黑河", @"怀化", @"呼和浩特", @"海口", @"呼伦贝尔", @"葫芦岛", @"淮南", @"衡水", @"黄山", @"黄石", @"和田", @"河源", @"衡阳", @"杭州", @"湖州", @"惠州", @"合作", @"汉中", @"菏泽", @"毫州", @"贺州"]},
                     @{@"name":@"J",@"array":@[@"吉安", @"金昌", @"晋城", @"金华", @"九江", @"吉林", @"江门", @"荆门", @"佳木斯", @"济南", @"济宁", @"酒泉", @"吉首", @"嘉兴", @"鸡西", @"揭阳", @"嘉峪关", @"锦州", @"晋中", @"焦作", @"荆州"]},
                     @{@"name":@"K",@"array":@[@"库尔勒", @"开封", @"凯里", @"克拉玛依", @"昆明", @"喀什"]},
                     @{@"name":@"L",@"array":@[@"六安", @"来宾", @"聊城", @"临沧", @"廊坊", @"漯河", @"丽江", @"吕梁", @"陇南", @"六盘水", @"丽水", @"拉萨", @"乐山", @"莱芜", @"临夏", @"辽阳", @"辽源", @"临沂", @"洛阳", @"龙岩", @"连云港", @"兰州", @"泸州", @"柳州"]},
                     @{@"name":@"M",@"array":@[@"马鞍山", @"牡丹江", @"茂名", @"眉山", @"绵阳", @"梅州"]},
                     @{@"name":@"N",@"array":@[@"宁波", @"南充", @"南昌", @"宁德", @"内广安", @"南京", @"内江", @"南宁", @"南平", @"南通", @"南阳"]},
                     @{@"name":@"P",@"array":@[@"平顶山", @"盘锦", @"平凉", @"莆田", @"萍乡", @"濮阳", @"攀枝花"]},
                     @{@"name":@"Q",@"array":@[@"青岛", @"秦皇岛", @"曲靖", @"齐齐哈尔", @"七台河", @"清远", @"庆阳", @"衢州", @"泉州", @"钦州"]},
                     @{@"name":@"R",@"array":@[@"日照"]},
                     @{@"name":@"S",@"array":@[@"韶关", @"上海", @"石家庄", @"商洛", @"思茅", @"三明", @"三门峡", @"遂宁", @"四平", @"宿迁", @"商丘", @"上饶", @"汕头", @"绍兴", @"沈阳", @"松原", @"十堰", @"邵阳", @"三亚", @"双鸭山", @"苏州", @"深圳", @"朔州", @"宿州", @"随州", @"石嘴山"]},
                     @{@"name":@"T",@"array":@[@"泰安", @"台北", @"塔城", @"铜川", @"通化", @"天津", @"铁岭", @"通辽", @"铜陵,", @"吐鲁番", @"铜仁", @"天水", @"唐山", @"太原", @"台州", @"泰州", @"台中",]},
                     @{@"name":@"W",@"array":@[@"潍坊", @"乌海", @"威海", @"芜湖", @"武汉", @"乌兰察布", @"乌兰浩特", @"乌鲁木齐", @"渭南", @"武威", @"无锡", @"温州", @"吴忠", @"梧州"]},
                     @{@"name":@"X",@"array":@[@"西安", @"宣城", @"许昌", @"襄樊", @"香港", @"孝感", @"厦门", @"西宁", @"咸宁", @"邢台", @"湘潭", @"新乡", @"咸阳", @"信阳", @"兴义", @"新余", @"徐州", @"忻州"]},
                     @{@"name":@"Y",@"array":@[@"延安", @"雅安", @"宜宾", @"盐城", @"伊春", @"银川", @"运城", @"宜昌", @"宜春", @"云浮", @"阳江", @"延吉", @"营口", @"榆林", @"玉林", @"伊宁", @"阳泉", @"烟台", @"鹰潭", @"玉溪", @"岳阳", @"益阳", @"扬州", @"永州"]},
                     @{@"name":@"Z",@"array":@[@"淄博", @"自贡", @"珠海", @"镇江", @"湛江", @"张家界", @"周口", @"驻马店", @"重庆", @"肇庆", @"舟山", @"中山", @"昭通", @"中卫", @"张掖", @"资阳", @"遵义", @"长治", @"枣庄", @"郑州", @"株洲", @"漳州"]}];
    self.dataNameArr = [[NSMutableArray alloc]init];
    for (NSDictionary* dic in self.dataArr) {
        [self.dataNameArr addObject:dic[@"name"]];
    }
}
-(void)initNav{
    UILabel* titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_AND_NAV_BAR_HEIGHT)];
    titleLb.text = @"定位";
    titleLb.backgroundColor = [UIColor redColor];
    titleLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLb];
}
-(void)initViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //修改索引颜色
    _tableView.sectionIndexColor = [UIColor darkGrayColor];//修改右边索引字体的颜色
    [self.view addSubview:_tableView];
}
-(void)initLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    //设置代理为自己
    _locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {    // 定位管理器 开始更新位置
        [_locationManager startUpdatingLocation];
    } else {
        NSLog(@"无法获取定位权限，请至系统设置打开定位权限");
    }
}
-(void)selectLocalArea{
    //点击了定位的地点-若有block则回调，不然进入下个界面
    if ([_localBtn.titleLabel.text isEqualToString:@"定位失败"]) {
        [self acquireLocationWithCityName:_localBtn.titleLabel.text];
    }
}
-(void)acquireLocationWithCityName:(NSString*)cityName{
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:cityName completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
//            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            
            //点击了列表的城市
            
        } else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}
#pragma mark - delegate
//CLLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            [self.localBtn setTitle:city forState:UIControlStateNormal];
            NSLog(@"city = %@", city);
        } else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}
// UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSArray* array = self.dataArr[section][@"array"];
        return array.count;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView* headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        headV.backgroundColor = [UIColor whiteColor];
        UIView* seperateV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        seperateV.backgroundColor = RGB(243, 243, 243);
        [headV addSubview:seperateV];
        
        [headV addSubview:self.localBtn];
        
        UIView* bottomV = [[UIView alloc]initWithFrame:CGRectMake(10, 59, SCREEN_WIDTH-20, 1)];
        bottomV.backgroundColor = RGB(243, 243, 243);
        [headV addSubview:bottomV];
        return headV;
    }else{
        UIView* headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        headV.backgroundColor = [UIColor whiteColor];
        UIView* seperateV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        seperateV.backgroundColor = RGB(243, 243, 243);
        [headV addSubview:seperateV];
        UILabel* titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-10, 30)];
        titleLb.text = self.dataArr[section][@"name"];
        titleLb.textColor = [UIColor lightGrayColor];
        titleLb.font = [UIFont systemFontOfSize:14.0f];
        [headV addSubview:titleLb];
        return headV;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        KKLocalHotCityTableViewCell* cell = [KKLocalHotCityTableViewCell createKKLocalHotCityTableViewCellWithTableView:tableView];
        cell.hotCityArr = self.dataArr[indexPath.section][@"array"];
        cell.HotCityClickBlock = ^(NSString* name) {
            //点击了热门城市
            [self acquireLocationWithCityName:name];
        };
        return cell;
    }else{
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray* array = self.dataArr[indexPath.section][@"array"];
        cell.textLabel.text = array[indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        //地理编码-根据城市名获取经纬度
        [self acquireLocationWithCityName:self.dataArr[indexPath.section][@"array"][indexPath.row]];
    }
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.dataNameArr;
}
#pragma mark - property
-(UIButton *)localBtn{
    if (!_localBtn) {
        _localBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 200, 60)];
        [_localBtn addTarget:self action:@selector(selectLocalArea) forControlEvents:UIControlEventTouchUpInside];
        [_localBtn setTitle:@"定位失败" forState:UIControlStateNormal];
        [_localBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_localBtn setImage:[UIImage imageNamed:@"tribe_local"] forState:UIControlStateNormal];
        _localBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _localBtn;
}
@end
