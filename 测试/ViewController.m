//
//  ViewController.m
//  测试
//
//  Created by yuanbo on 2017/12/27.
//  Copyright © 2017年 com.AlongChat. All rights reserved.
//

#import "ViewController.h"
#import "yblabel.h"
#import "yblabelaaa.h"
#import "UILabel+aaalabel.h"
#import "UILabel+bbblabel.h"
#import "UIColor+Color.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TSLibraryImport.h"
#import "PGQAnimationShow.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSURL *_url;
    NSMutableArray *musicsList;
    int _num;
    NSString * _sandboxPath;
    NSArray *_sandboxSongList;
}

#pragma mark -获取iTunes中的数据
- (void)getiTuneLibrary{
    // 创建媒体选择队列（从ipod库中读出音乐文件）
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    // 创建读取条件(类似于对数据做一个筛选)  Value：作用等同于MPMediaType枚举值
    MPMediaPropertyPredicate *albumNamePredicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInt:MPMediaTypeMusic ] forProperty: MPMediaItemPropertyMediaType];
    //给队列添加读取条件
    [everything addFilterPredicate:albumNamePredicate];
    //从队列中获取符合条件的数组集合
    NSArray *itemsFromGenericQuery = [everything items];
    //便利解析数据
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (MPMediaItem *song in itemsFromGenericQuery) {
            [self resolverMediaItem:song];
            _num ++;
            if (_num == 5) {
                return;
            }
        }
//    });
}

#pragma mark -解析iTune音乐数据
- (void)resolverMediaItem:(MPMediaItem *)song{
    //歌名
    NSString *name = [song valueForProperty: MPMediaItemPropertyTitle];
    //歌曲路径
    NSURL *url = [song valueForProperty: MPMediaItemPropertyAssetURL];
    //歌手名字
    NSString *songer = [song valueForProperty: MPMediaItemPropertyArtist];
    //歌曲时长（单位：秒）
    NSTimeInterval INW = [[song valueForProperty: MPMediaItemPropertyPlaybackDuration] doubleValue];
    NSString *time;
    if((int)INW%60<10) {
        time = [NSString stringWithFormat:@"%d:0%d",(int)INW/60,(int)INW%60];
    } else {
        time = [NSString stringWithFormat:@"%d:%d",(int)INW/60,(int)INW%60];
    }
    if(songer == nil) {
        songer = @"未知歌手";
    }
    //歌曲插图（如果没有插图，则返回nil）
    MPMediaItemArtwork *artwork = [song valueForProperty: MPMediaItemPropertyArtwork];
    //从插图中获取图像，参数size是图像的大小
    UIImage *image = [artwork imageWithSize:CGSizeMake(50, 50)];
    
    //    DebugLog(@"%@",[NSString stringWithFormat:@"歌名：%@ \n 歌曲路径：%@ \n 歌手名字:%@ \n 歌曲时长%@ \n 歌曲插图：%@",name,url,songer,time,image]);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:url.absoluteString forKey:@"url"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:songer forKey:@"songer"];
    [dic setValue:time forKey:@"time"];
    [dic setValue:image forKey:@"image"];
    [musicsList addObject:dic];
    _url = url;
}
- (void)aaa {
//    _sandboxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    _sandboxSongList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:_sandboxPath error:nil]];
//    NSLog(@"%ld",_sandboxSongList.count);
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperation *a;
    for (int i = 0; i < _num; i ++) {
        ////         NSLog(@"%@,%@",musicsList[i][@"url"],musicsList[i][@"name"]);
        NSString* ext = [TSLibraryImport extensionForAssetURL:[NSURL URLWithString:musicsList[i][@"url"]]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSURL* outURL = [[NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:musicsList[i][@"name"]]] URLByAppendingPathExtension:ext];
        //                 NSLog(@"--------%@",outURL);
        TSLibraryImport* import = [[TSLibraryImport alloc] init];
        a = [NSBlockOperation blockOperationWithBlock:^{
            [import importAsset:[NSURL URLWithString:musicsList[i][@"url"]] toURL:outURL completionBlock:^(TSLibraryImport *import) {
                NSLog(@"%ld",(long)import.status);
                //                    NSLog(@"%@",outURL);
                //            NSFileManager *fileManager1 = [NSFileManager defaultManager];
                //            _sandboxSongList = [[NSArray alloc] initWithArray:[fileManager1 contentsOfDirectoryAtPath:_sandboxPath error:nil]];
                //            NSLog(@"------%ld",_sandboxSongList.count);
                //            ==3 succ
                NSLog(@"1");
            }];
        }];
    }
    // 创建2个操作
    NSOperation *b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"---2");
    }];
    [b addDependency:a];
    [queue addOperation:a];
    [queue addOperation:b];

    
//    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:DocumentsPath];
//    for (NSString *fileName in enumerator) {
//        [[NSFileManager defaultManager] removeItemAtPath:[DocumentsPath stringByAppendingPathComponent:fileName] error:nil];
//        //            NSLog(@"%@",fileName);
//        //            NSLog(@"%@",[NSString stringWithFormat:@"%@,%@",DocumentsPath,fileName]);
//    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    _num = 0;
    musicsList = [NSMutableArray array];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSLog(@"%@",countryCode);
    
//        [[PGQAnimationShow shareInstance]showLoadingWithMessage:@"这里有你想要的" backColor:[UIColor yellowColor] frame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100) superView:self.view];
    
//    [self getiTuneLibrary];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];

    
    
//    全部删除
//    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:DocumentsPath];
//    for (NSString *fileName in enumerator) {
//        [[NSFileManager defaultManager] removeItemAtPath:[DocumentsPath stringByAppendingPathComponent:fileName] error:nil];
//    }

    
//    yblabelaaa *a = [[yblabelaaa alloc]init];
//    [self.view addSubview:a];
//    [a hahaha];
    
//    UILabel *label = [[UILabel alloc]init];
//    yblabel *aa = [[yblabel alloc]init];
//
//    label.frame = CGRectMake(50, 100, 200, 200);
//    aa.frame = CGRectMake(100, 400, 200, 200);
//    [self.view addSubview:label];
//    [self.view addSubview:aa];
//
//    NSNumber *number = [NSNumber numberWithBool:YES];
//    NSLog(@"%d",[number boolValue]);
//    aa.string2 = @"aa";
//    NSLog(@"%@",aa.string2);
//     NSLog(@"str1 == %@",label.str1);
//    NSLog(@"string1 = %@",label.string1);
//    aa.string1 = @"string1";
////    [aa eat];
////    [aa strlog];
////    [aa strlog1];
////    NSLog(@"str = %@",label.str);
////    NSLog(@"str == %@ /n str1 == %@",label.str,label.str1);
////    [label strlog];
////    [label strlog1];
////    [label eat];
////    [label run];
////    NSLog(@"str == %@ /n str1 == %@",label.str,label.str1);
//      NSLog(@"str1 == %@",label.str1);
//    NSLog(@"string1 = %@",label.string1);
////     NSLog(@"str = %@",label.str);
}



















//
//
//
//
//UIImageView *aaa = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG1.jpeg"]];
//aaa.frame = self.view.frame;
//[self.view addSubview:aaa];
//
//UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(140, 209, 150, 68)];
////    label3.textAlignment = NSTextAlignmentRight;
//label4.backgroundColor = [UIColor colorWithHexString:@"F1F1F1"];
//label4.text = @"13210";
//label4.textColor = [UIColor blackColor];
//label4.font =[UIFont fontWithName:@"Helvetica-Bold" size:32];
//[self.view addSubview:label4];
//
//UILabel *aaaaa = [[UILabel alloc]initWithFrame:CGRectMake(233, 212, 20, 66)];
//aaaaa.textAlignment = NSTextAlignmentLeft;
//aaaaa.backgroundColor = [UIColor colorWithHexString:@"F1F1F1"];
//aaaaa.text = @"元";
//aaaaa.textColor = [UIColor blackColor];
//aaaaa.font = [UIFont systemFontOfSize:16];
//[self.view addSubview:aaaaa];
//
//UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(285, 365, 80, 20)];
//label1.textAlignment = NSTextAlignmentRight;
//label1.backgroundColor = [UIColor whiteColor];
//label1.text = @"35300元";
//label1.textColor = [UIColor blackColor];
//label1.font = [UIFont systemFontOfSize:18];
//[self.view addSubview:label1];
//
//UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(285, 435, 80, 20)];
//label2.textAlignment = NSTextAlignmentRight;
//label2.backgroundColor = [UIColor whiteColor];
//label2.text = @"13210元";
//label2.textColor = [UIColor blackColor];
//label2.font = [UIFont systemFontOfSize:18];
//[self.view addSubview:label2];
//
//UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(285, 509, 80, 20)];
//label3.textAlignment = NSTextAlignmentRight;
//label3.backgroundColor = [UIColor whiteColor];
//label3.text = @"0.01元";
//label3.textColor = [UIColor blackColor];
//label3.font = [UIFont systemFontOfSize:18];
//[self.view addSubview:label3];




- (void)sp_getUserFollowSuccess735766622 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo914345814 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3799011561 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1075390025 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3757678830 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo91077472 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking2216460430 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3012086132 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2986654426 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3279359044 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1200433899 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3387576770 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3747919005 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2376761729 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2522405594 {
    NSLog(@"Continue");
}

- (void)sp_upload1252895124 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3400577006 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3453583685 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName820321166 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1309534175 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1782872954 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess4235775827 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3847706394 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3624414183 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3518783689 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3423314326 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3139844195 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1196896185 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess985882028 {
    NSLog(@"Continue");
}

- (void)sp_upload577529964 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1015554554 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed739419936 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2983290344 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess2072440675 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess2459311341 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked3871697338 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2958434003 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2768983028 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2120716584 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess3879186000 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3825295691 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2885310005 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo547014439 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3277119733 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3633062189 {
    NSLog(@"Continue");
}

- (void)sp_upload2567342331 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2020655214 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2972192732 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess466212085 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3086452544 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2148748783 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1659025339 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2488217002 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2262503646 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName53500628 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2150274865 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1443750642 {
    NSLog(@"Continue");
}

- (void)sp_upload4171242077 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1753294685 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2799908171 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2739958155 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed690234853 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2278117008 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2354498104 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2549481709 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting970487885 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload128723587 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting366641354 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1899528649 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting4084012962 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3097811807 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed545702777 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2264740647 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1095109455 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2646774819 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3921323964 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1661646546 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2320138647 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2219488009 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData4040750442 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1122788895 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1411634314 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData2839149263 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess773334389 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting4009733759 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1407994848 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData4266399692 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3699298893 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3461030991 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1441997713 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess184705900 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess3184861475 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo466727092 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess72192941 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess577747457 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1056473180 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3710363375 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo4047796071 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking728826326 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1794940867 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2250029742 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed109149172 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload697220267 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2264263454 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2035549669 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1484854529 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3724264863 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1927270854 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo4004164295 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1924197007 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2030401910 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo68344121 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3463316849 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo591336753 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3884352222 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2237312999 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2338792831 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo91298582 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2099171926 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2577226525 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3711380727 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed2938080113 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3094890841 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2332507665 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3150130657 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess4226605278 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2168429814 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2228792698 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3425284193 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking359160066 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2073324668 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1322751378 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3147715653 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed889084402 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3373998000 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed3675285247 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed4135946417 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2464962198 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed703848306 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1269930766 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3621976406 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3319631279 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo860976584 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3107269905 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess4216067443 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2117478334 {
    NSLog(@"Continue");
}

- (void)sp_upload4274932472 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState3762171611 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3408457326 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3662066503 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1319786164 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1994213565 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3534858495 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData4011190517 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1559973411 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3262373586 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1310006436 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload128722708 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3754764160 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2646825549 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1208241798 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1919604602 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2590476509 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2533453675 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3661312775 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked39289206 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1505914948 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2768205342 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess669213742 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked3779638426 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1055688363 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo287676314 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3250338765 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3513877183 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2751132703 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1840176978 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3230800146 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2895551315 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2339028253 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed850562963 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3929303695 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2988254152 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2802581088 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1803060395 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1553773120 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess426506227 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3324423522 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2120905951 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3359708230 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1658758537 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3229077471 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3165664470 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed138626681 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2626841744 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1881271240 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1241431581 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2526588210 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess893670107 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1632050374 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2584853353 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1506557481 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1532899362 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3460706148 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2322710470 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2226363540 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2762079873 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2015191173 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3860064489 {
    NSLog(@"Continue");
}

- (void)sp_getUserName392320209 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3454109879 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed217877738 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3553691492 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3021956578 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState4055238180 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked2313343619 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3415188760 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3937403781 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo4231034619 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed80466012 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1382849329 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3652870369 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2562944064 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3635191631 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed51629531 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2989497639 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2303099227 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3248600816 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1476924485 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1351129829 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3644997357 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3378563347 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2834386456 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2577286292 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3783932399 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1658291881 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess780987659 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3485172732 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1202639774 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2327829693 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3639889085 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking2962514107 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1958884214 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2527094718 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked521959937 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1782202746 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1482176551 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3427082559 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData4203388306 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1130589680 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3602228869 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess380293637 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked254307328 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3214216772 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName3364347748 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed333369487 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess673004850 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState729907695 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo961803228 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData4214268031 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1514273033 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2996923672 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1305753445 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1548022007 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3191717279 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2783287429 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1611323422 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3154038492 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1481899905 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess4243888493 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed869428654 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed896557350 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess827562061 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess4108710723 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed552875527 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2092199703 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1819222637 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3043242793 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2923596278 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed231401026 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2986354139 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2804471778 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2128934105 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3330215602 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2288320982 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData1268348957 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3095673555 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1647891859 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed4749614 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1946604853 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3996736229 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1980022810 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo354876306 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2832750725 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3692321589 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1439145569 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3370947568 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1282293016 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1811557358 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2397655958 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2422645691 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1406707064 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1122473588 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState217501716 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2543195834 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2240084008 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2497217178 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked280769467 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess774530667 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2059642995 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1418992984 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName89118755 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1557815809 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo4077875572 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1089441701 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1051913996 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3327972658 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1070756814 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting96862283 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess687126070 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed4104428703 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2600567547 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess198879050 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1897447607 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed580989255 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1009628295 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1571122762 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName704928275 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess519458609 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking1089039869 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1437746660 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting4248657538 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3446917475 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3387900341 {
    NSLog(@"Continue");
}

- (void)sp_upload2218486409 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1456673492 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1255310963 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed987849396 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1546280123 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked811922436 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess396483209 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2504962596 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2434059320 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState651565602 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1499584983 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2936420514 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2453058963 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData395384401 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1738285085 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo4210859430 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked4193046985 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1930707476 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2123589033 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2402951856 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess609274743 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2064011244 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1597229416 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2617019560 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3262511892 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo685234519 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1141620563 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState258455711 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1972579640 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess946463425 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2610427846 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1683350031 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo423345920 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1111349383 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2179620415 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed4272389381 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2386921023 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1264274365 {
    NSLog(@"Continue");
}

- (void)sp_getUserName1148288647 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3909859322 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed53779744 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload616777014 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking508828967 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo3565483554 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed2286853247 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1326924305 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo898489684 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1741478312 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2405396626 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3164469747 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1683674927 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData4144204265 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3749152582 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2204083807 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3857427622 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed1905875185 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2076080893 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo653511049 {
    NSLog(@"Check your Network");
}

- (void)sp_upload3289578608 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3285341598 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1475917583 {
    NSLog(@"Continue");
}

- (void)sp_upload1397242904 {
    NSLog(@"Continue");
}

- (void)sp_upload2929418378 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1010894458 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking388594488 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo4214411244 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2811266915 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1065058424 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1623002146 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2543885795 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3328970123 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2678203433 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2367905078 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess66394013 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName3302962185 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2179553250 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess546893994 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName1181442542 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed1859723440 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3091827573 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData2272589592 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3811259867 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3998146885 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2291655302 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2405780673 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState1973405806 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2226983355 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3065353488 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess218329183 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2485436825 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2458043461 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2977314980 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo171620264 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2669805471 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed1940918611 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1266375687 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess209113577 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1478404054 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3747503393 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3535492824 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess625252546 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1236635949 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload3648664566 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName754679268 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2641509167 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting160376197 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1105878111 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3355290305 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2687556151 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2412176248 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2928247148 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3707883568 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2338266070 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3744768234 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload706060703 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1154981843 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1939153475 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3509695382 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1266780465 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2174964341 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3483264573 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3092262134 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2320957359 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2802602362 {
    NSLog(@"Check your Network");
}

- (void)sp_upload751821224 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2692154227 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1533385674 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1711832333 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1407435151 {
    NSLog(@"Continue");
}

- (void)sp_getUserName4048950257 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess243156813 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed3760566200 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2248577211 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3203771937 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess826832183 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1447336685 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1888218788 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3121944175 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1970929091 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2502207894 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2480515807 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2283756407 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo447046459 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1514381173 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2042609271 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1236832839 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4035911206 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3350546409 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2289205454 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1035251236 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2424409612 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState82354035 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess900824676 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1494446470 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2125405626 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2167757567 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1998296158 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1514974574 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed210311052 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1613234651 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked3176080438 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1612520382 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting4102097248 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked975319031 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting238458360 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2284777387 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked691074390 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3317567094 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2902938204 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName832517528 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo878869703 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1073965723 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1818410368 {
    NSLog(@"Check your Network");
}

- (void)sp_upload678818653 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2597526750 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1480827146 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3236069887 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo568013139 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting107430219 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2587782250 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState1005769792 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1638005567 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2381330116 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3236449213 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3365956025 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3049289857 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3639265302 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState5148345 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1616255075 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess127899499 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1614139754 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3275679203 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3884487354 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3458816589 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3313437161 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked737779019 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1503455532 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2462135340 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2598909015 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed473821795 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed631881383 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3431768186 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1566389446 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2158618225 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2804476340 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState1561535795 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2551898196 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed4293868250 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2253630757 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3730851146 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3105041408 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3788280324 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1007513037 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3481899361 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2996825045 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess597125008 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData4274765339 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess526563761 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1255547993 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2528537297 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3204544168 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess3905812850 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3022513307 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2251143513 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2410375349 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2746398570 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData4077329930 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3104264267 {
    NSLog(@"Continue");
}

- (void)sp_upload1111452125 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking646238407 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2711666825 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed467327603 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo230360707 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3387098755 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2761350153 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2879506090 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2828313612 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking113900726 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName205691977 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3405300743 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1652588747 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2340076541 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3753919492 {
    NSLog(@"Check your Network");
}

- (void)sp_upload947895261 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3739661377 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2905391747 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess546090402 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3185755051 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1456628269 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2374409304 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3426341430 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess4286423294 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3322766025 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3295716544 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked418874216 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1870357951 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3283989097 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1316421420 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2152692008 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3527036370 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2012219553 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo4178483637 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3460304111 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3991294189 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3428565639 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3775845899 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2435940563 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1644627152 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1828356523 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2103067461 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1293915901 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed877025118 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed4048619341 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1159094728 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3685423961 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1969411248 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3111948977 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed2667554934 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1651495369 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData99830189 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2871216361 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2999112118 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1663279855 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2704743720 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1380632008 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3418662356 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1996690713 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3981266914 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess3271964232 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3297558230 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo4030249996 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2882944581 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3873735974 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2028670143 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3802621473 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1762513934 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1931810170 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting257641176 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess1875382976 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed1142844827 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess2419133783 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2352220235 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3330335544 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess596496256 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked569230112 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2819044423 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1412316512 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName869081850 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess660869773 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess1223271920 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1086364407 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2119044914 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1045647472 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting3098994757 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1724952989 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1678051437 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2151819864 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess1717731883 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3723652085 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3128845615 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed2119445402 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed4207872262 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2639931407 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3040800113 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName273886972 {
    NSLog(@"Continue");
}

- (void)sp_upload1820905469 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked3804597725 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2037157833 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2465946047 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2736643296 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1544830978 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2166900411 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2035687985 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2077459119 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3952335406 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2450320042 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3726861807 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1840135368 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload301343551 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3687815802 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2467386570 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked3243495629 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2796556278 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo3469041636 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed809748906 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2133907552 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2635376656 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo3679760847 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3321343376 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1194134542 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed44027434 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo4918301 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2626763713 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting4190100494 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2375522235 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1372056712 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2679687689 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3694587353 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed193028954 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1268440236 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed1076648247 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData687426258 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1574781583 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2513734669 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1943405759 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3099218108 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2899169688 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess612630532 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3432116046 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1420998917 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName390184292 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1472294540 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3165037596 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess515515225 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3529234071 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName285870915 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1164026247 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked4209326035 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess4227309090 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2852069116 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1000339546 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1812916576 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3522373390 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess85122230 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1325673342 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2039972869 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState584151947 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed2844332667 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3380728120 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4268948528 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3097071594 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3440987016 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1047645103 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed945549590 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload4269581029 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3878329552 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1578077478 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess2405575322 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting671202840 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess736663181 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess4102804790 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1151269035 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo462450732 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo4207342155 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1964525238 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess1079860601 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3776329841 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo5666241 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess3153331237 {
    NSLog(@"Continue");
}

- (void)sp_upload3865239256 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1094551199 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3480221496 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2960206093 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo549904334 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2107385311 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo1330287794 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState29154346 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData4239308379 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2356842326 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3055861489 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed4122304896 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3918466035 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess77188520 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2171801550 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1884117097 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2687621574 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess4021762413 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3008901132 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3001118404 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3978935592 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1006016111 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName917971785 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2530757669 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess359439706 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3137388805 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2392191694 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3678813002 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess4177198255 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2801427100 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload550380174 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3344882840 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1679684712 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1341076046 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName265448799 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2496332338 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess729672987 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess547363057 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess205304200 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess428028741 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData1888904172 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked1721759211 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2765531121 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed158010227 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3569083999 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3983143337 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2613239923 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo927610174 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess269410684 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3413959619 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed878368152 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload2229239917 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1455385705 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2193716053 {
    NSLog(@"Get User Succrss");
}
@end
