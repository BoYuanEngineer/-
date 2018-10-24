//
//The MIT License
//
//Copyright (c) 2010 tapsquare, llc., (http://www.tapsquare.com, art@tapsquare.com)
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//

#import "TSLibraryImport.h"
#import <AVFoundation/AVFoundation.h>

@interface TSLibraryImport()

+ (BOOL)validIpodLibraryURL:(NSURL*)url;
- (void)extractQuicktimeMovie:(NSURL*)movieURL toFile:(NSURL*)destURL;

@end


@implementation TSLibraryImport

+ (BOOL)validIpodLibraryURL:(NSURL*)url {
	NSString* IPOD_SCHEME = @"ipod-library";
	if (nil == url) return NO;
	if (nil == url.scheme) return NO;
	if ([url.scheme compare:IPOD_SCHEME] != NSOrderedSame) return NO;
	if ([url.pathExtension compare:@"mp3"] != NSOrderedSame &&
		[url.pathExtension compare:@"aif"] != NSOrderedSame &&
		[url.pathExtension compare:@"m4a"] != NSOrderedSame &&
		[url.pathExtension compare:@"wav"] != NSOrderedSame) {
		return NO;
	}
	return YES;
}

+ (NSString*)extensionForAssetURL:(NSURL*)assetURL {
	if (nil == assetURL)
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"nil assetURL" userInfo:nil];
	if (![TSLibraryImport validIpodLibraryURL:assetURL])
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Invalid iPod Library URL: %@", assetURL] userInfo:nil];
	return assetURL.pathExtension;
}

- (void)doMp3ImportToFile:(NSURL*)destURL completionBlock:(void (^)(TSLibraryImport* import))completionBlock {
	//TODO: instead of putting this in the same directory as the dest file, we should probably stuff
	//this in tmp
	NSURL* tmpURL = [[destURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"mov"];
	[[NSFileManager defaultManager] removeItemAtURL:tmpURL error:nil];
	exportSession.outputURL = tmpURL;
	
	exportSession.outputFileType = AVFileTypeQuickTimeMovie;
	[exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
		if (exportSession.status == AVAssetExportSessionStatusFailed) {
			completionBlock(self);
		} else if (exportSession.status == AVAssetExportSessionStatusCancelled) {
			completionBlock(self);
		} else {
			@try {
				[self extractQuicktimeMovie:tmpURL toFile:destURL];
			}
			@catch (NSException * e) {
				OSStatus code = noErr;
				if ([e.name compare:TSUnknownError]) code = kTSUnknownError;
				else if ([e.name compare:TSFileExistsError]) code = kTSFileExistsError;
				NSDictionary* errorDict = [NSDictionary dictionaryWithObject:e.reason forKey:NSLocalizedDescriptionKey];
				
				movieFileErr = [[NSError alloc] initWithDomain:TSLibraryImportErrorDomain code:code userInfo:errorDict];
			}
			//clean up the tmp .mov file
			[[NSFileManager defaultManager] removeItemAtURL:tmpURL error:nil];
			completionBlock(self);
        }
		exportSession = nil;
	}];	
}

- (void)importAsset:(NSURL*)assetURL toURL:(NSURL*)destURL completionBlock:(void (^)(TSLibraryImport* import))completionBlock {
	if (nil == assetURL || nil == destURL)
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"nil url" userInfo:nil];
	if (![TSLibraryImport validIpodLibraryURL:assetURL])
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Invalid iPod Library URL: %@", assetURL] userInfo:nil];

	if ([[NSFileManager defaultManager] fileExistsAtPath:[destURL path]])
		 @throw [NSException exceptionWithName:TSFileExistsError reason:[NSString stringWithFormat:@"File already exists at url: %@", destURL] userInfo:nil];
	
	NSDictionary * options = [[NSDictionary alloc] init];
	AVURLAsset* asset = [AVURLAsset URLAssetWithURL:assetURL options:options];	
	if (nil == asset) 
		@throw [NSException exceptionWithName:TSUnknownError reason:[NSString stringWithFormat:@"Couldn't create AVURLAsset with url: %@", assetURL] userInfo:nil];
	
	exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetPassthrough];
	if (nil == exportSession)
		@throw [NSException exceptionWithName:TSUnknownError reason:@"Couldn't create AVAssetExportSession" userInfo:nil];
	
	if ([[assetURL pathExtension] compare:@"mp3"] == NSOrderedSame) {
		[self doMp3ImportToFile:destURL completionBlock:completionBlock];
		return;
	}

	exportSession.outputURL = destURL;
	NSLog(@"destURL = %@",destURL);
	// set the output file type appropriately based on asset URL extension
	if ([[assetURL pathExtension] compare:@"m4a"] == NSOrderedSame) {
		exportSession.outputFileType = AVFileTypeAppleM4A;
	} else if ([[assetURL pathExtension] compare:@"wav"] == NSOrderedSame) {
		exportSession.outputFileType = AVFileTypeWAVE;
	} else if ([[assetURL pathExtension] compare:@"aif"] == NSOrderedSame) {
		exportSession.outputFileType = AVFileTypeAIFF;
	} else {
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"unrecognized file extension" userInfo:nil];
	}

	[exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
		completionBlock(self);
		exportSession = nil;
	}];
}

- (void)extractQuicktimeMovie:(NSURL*)movieURL toFile:(NSURL*)destURL {
	FILE* src = fopen([[movieURL path] cStringUsingEncoding:NSUTF8StringEncoding], "r");
	if (NULL == src) {
		@throw [NSException exceptionWithName:TSUnknownError reason:@"Couldn't open source file" userInfo:nil];
		return;
	}
	char atom_name[5];
	atom_name[4] = '\0';
	unsigned long atom_size = 0;
	while (true) {
		if (feof(src)) {
			break;
		}
		fread((void*)&atom_size, 4, 1, src);
		fread(atom_name, 4, 1, src);
		atom_size = ntohl(atom_size);
        const size_t bufferSize = 1024*100;
		if (strcmp("mdat", atom_name) == 0) {
			FILE* dst = fopen([[destURL path] cStringUsingEncoding:NSUTF8StringEncoding], "w");
			unsigned char buf[bufferSize];
			if (NULL == dst) {
				fclose(src);
				@throw [NSException exceptionWithName:TSUnknownError reason:@"Couldn't open destination file" userInfo:nil];
			}
            // Thanks to Rolf Nilsson/Roni Music for pointing out the bug here:
            // Quicktime atom size field includes the 8 bytes of the header itself.
            atom_size -= 8;
            while (atom_size != 0) {
                size_t read_size = (bufferSize < atom_size)?bufferSize:atom_size;
                if (fread(buf, read_size, 1, src) == 1) {
                    fwrite(buf, read_size, 1, dst);
                }
                atom_size -= read_size;
            }
			fclose(dst);
			fclose(src);
			return;
		}
		if (atom_size == 0)
			break; //0 atom size means to the end of file... if it's not the mdat chunk, we're done
		fseek(src, atom_size, SEEK_CUR);
	}
	fclose(src);
	@throw [NSException exceptionWithName:TSUnknownError reason:@"Didn't find mdat chunk"  userInfo:nil];
}

- (NSError*)error {
	if (movieFileErr) {
		return movieFileErr;
	}
	return exportSession.error;
}

- (AVAssetExportSessionStatus)status {
	if (movieFileErr) {
		return AVAssetExportSessionStatusFailed;
	}
	return exportSession.status;
}

- (float)progress {
	return exportSession.progress;
}



- (void)sp_didUserInfoFailed3342710368 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3542180757 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess772288409 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName964359553 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2161235164 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed1044706428 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo4004717222 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3948451631 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3539017503 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1777600422 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3421620847 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3121706251 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking1401078670 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1261201731 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess1463971250 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2964941516 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2184557828 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1621843605 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3432083033 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess564652214 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1642557455 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName317821887 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1525154698 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess626947415 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3447238835 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName327076438 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2520439263 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1022139165 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting1444677991 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking2930825949 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1277285013 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2361479538 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess382834352 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2406615245 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState3477118703 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3736936078 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1990957634 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3237503818 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2335938077 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3108525802 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess4280259955 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2488750793 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1152965402 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2996768459 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3424074537 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3459249292 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked187675980 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState942524453 {
    NSLog(@"Continue");
}

- (void)sp_upload2797788168 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting960628090 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3326650541 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed975013563 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2939115777 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3314233899 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1382359032 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed4151644930 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3620093752 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3617699600 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2826906952 {
    NSLog(@"Continue");
}

- (void)sp_upload1528354419 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2042745605 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2391061161 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed4106105009 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3976597115 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2833919677 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting158430885 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking4174361865 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo856425127 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo1925701531 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2227376481 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess424721118 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1236337500 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2494136718 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1150926866 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo824996229 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess395053534 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1870462345 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2433275718 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName19610590 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1336034220 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1478265706 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3651274178 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3016496346 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2381223109 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState1503918096 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2446447900 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2338737628 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1066023495 {
    NSLog(@"Check your Network");
}

- (void)sp_upload646952395 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo764486831 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1472043631 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3265838757 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName393999513 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess3877671018 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2271203839 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed4071736045 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking2537693808 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2193329042 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess4118612497 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState2899945841 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked2123308221 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting2342033292 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3861661565 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData129460262 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2116973202 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1309202528 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess701866764 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2271095814 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData2653626743 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3890696289 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2767521989 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1506682572 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3854812249 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed660313049 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed80684464 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3047727097 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed1667605424 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking266197158 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3419329590 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2179343287 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked289140077 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2900689470 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1840269298 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1191838661 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked2519658478 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1209146543 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess506341362 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2655861784 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2279899289 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3532367796 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed4080827497 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed338243057 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2770680473 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3273746988 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2130153346 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess534381309 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3694725485 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1855803567 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3540775893 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2208974697 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState970812595 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState655181715 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess441499364 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess3628464651 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1240264024 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2495535842 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1763966647 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess162988014 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking436562256 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2175722477 {
    NSLog(@"Continue");
}

- (void)sp_upload2174832170 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2947769503 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2653760117 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess54331944 {
    NSLog(@"Check your Network");
}

- (void)sp_upload3919252582 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess4066380644 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess295319830 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3058578885 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload309896279 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2806147636 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1383155884 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2582041175 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState816643207 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1016592522 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3337817765 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3919887266 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting195120338 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2196946431 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo566998749 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1693205961 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed4202993321 {
    NSLog(@"Continue");
}

- (void)sp_upload3949318371 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState2530197537 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1529797464 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3139572054 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2204651286 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess4262056422 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed380449478 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed247924319 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData892746958 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3871732319 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload3323549166 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess175682223 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2774914029 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2320036763 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3940045335 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2928104623 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1138458205 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess341721380 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1876039837 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1883165882 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3363855349 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1862671359 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2832997873 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1057854342 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3346814925 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking4129401249 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName4144990896 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3534043928 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1263178536 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo2454890890 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3001062093 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3182858240 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess4022094530 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo747269069 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData889692942 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3668300794 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking4227474115 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2590812089 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2547476521 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState54503059 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2739808239 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed1766020144 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3843494133 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName1799450285 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1123161945 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1929139733 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData956249810 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1757301632 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed863241380 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3522246967 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1346685731 {
    NSLog(@"Continue");
}

- (void)sp_upload3699056771 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1507371876 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1970896864 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess49213742 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2813839928 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo899630959 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState698288151 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked925086205 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3859061379 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3437755514 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess4066684779 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2060697006 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3818262504 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1991411953 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2668753906 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2465701094 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData4242320092 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2773366517 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1563898516 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess191908251 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting885954252 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3601323613 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1972167426 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting4086198689 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess899575649 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess753230079 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName4165957168 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1850943014 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2018041810 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3373664982 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState4273562713 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess944460185 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2808457264 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3713434491 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2747391525 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked2155182838 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking3946838374 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload235432836 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2254365510 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting877740214 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking727012357 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2829609303 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3047480724 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked2105833492 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting1956389381 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3341217852 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo390297771 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3606298633 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2548632086 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1278499690 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess330424961 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2423602210 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess466718507 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3615897771 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1237806639 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload2870257639 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo983825303 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1078870082 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1451701006 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1826878336 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2745880763 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess909313769 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData3973048154 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed440085189 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1107663157 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess3501883063 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2955542236 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2356432933 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess3286379005 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData457230104 {
    NSLog(@"Continue");
}

- (void)sp_getUserName3822834070 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo662587283 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload130301602 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2838487660 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3456396431 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed4140024343 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData4085771088 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState1439360888 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1382373804 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess2487232061 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2392106176 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo318874778 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1580300971 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed351710203 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3605431218 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2923214201 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed107657602 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting70877478 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1794303496 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed3652019770 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3626806991 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed929054771 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1308106822 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3599860031 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking806449625 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2212958377 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed576986346 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess4208866831 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2788241356 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2733123821 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo333071255 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1299222427 {
    NSLog(@"Check your Network");
}

- (void)sp_upload862456699 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo921252353 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1445837328 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3100534656 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1650273564 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName4068729643 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed4032213635 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked1708095331 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed962046733 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking3586948610 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed4256563351 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked2876354879 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2019908576 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2999141777 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName779847583 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1858468629 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1311086620 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2937727524 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess521981561 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3992869515 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2808811061 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo800928645 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1263317264 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess473484775 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1873478760 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3611335421 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked796799204 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState784907031 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2478747049 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2250696989 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3439056960 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData296116312 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3372493374 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1818770362 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed487430805 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1473165386 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3365150042 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2114292648 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1089965352 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked1689244731 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3296371247 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1109586624 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess783403906 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed3402466422 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed509393768 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2933633898 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess458370109 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3368310006 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2479105684 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked45406077 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked3450043519 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState4665062 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData4152439568 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3918043361 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo709802726 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState3722368874 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState437787281 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3370435244 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2882382806 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2266822657 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo3922819196 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1115426402 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState27581445 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess1740123452 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1103883656 {
    NSLog(@"Continue");
}

- (void)sp_upload4101301002 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState4100967361 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo3253043405 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1162741084 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3545256170 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2134827853 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1466479278 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo1280591672 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3870593232 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1075388986 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2384441074 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo1288300530 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName2445574512 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3497030787 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked4025715533 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1110144190 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed1156382713 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking1580331695 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2193625258 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3330682076 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState330075677 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess1512552345 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed1097686225 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload4242174561 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo582090643 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess280807619 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2446236609 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2123713899 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3967294890 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1529887628 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess3814001099 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData4292744097 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload3709518868 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3040264576 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2310136944 {
    NSLog(@"Continue");
}

- (void)sp_getLoginState2148450976 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking2820745648 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1513416989 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1736035868 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData3615420413 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData959123098 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1139648045 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1639924691 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3287791522 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2636736086 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3089775792 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed3680395172 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2190783211 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked843238562 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLikedSuccess13121855 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2114173262 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess2801958543 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2884001818 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1334626416 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3705740872 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess2653471346 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2456143820 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2164487606 {
    NSLog(@"Check your Network");
}

- (void)sp_upload2769906842 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1441005470 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking3813297705 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState4136859673 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo930554254 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName3629795129 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1650897569 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1735326903 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1474825693 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1024869888 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess2837425656 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo1143697435 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1784725304 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess3104136073 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName3720223483 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData1464994890 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess1757329672 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo2527827944 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2979442930 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess809969840 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1189857175 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2173725002 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2626076102 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting2511948898 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName2986896880 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1981897574 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2000154252 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3348613112 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked4099792485 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed2105599489 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3744910508 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed506818494 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo1949349463 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1798057345 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1795545120 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3040061931 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload4005106471 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking1148695106 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess3187102934 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2707481726 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo2604155113 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess366615817 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess106672064 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed786966574 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed1377795869 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3681566718 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting3749002835 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed3373751889 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess1832527555 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2680059095 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3069250137 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2831792197 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData963147087 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed951061499 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess4092061157 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed2158608350 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload851460630 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName3761723182 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess3675619305 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess4079144656 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess3694235253 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1923501640 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2319292564 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed2604740555 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo528796673 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess3903135432 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked3023424077 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3251237183 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo1745878889 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2603505311 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked2835661690 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess1499439246 {
    NSLog(@"Check your Network");
}

- (void)sp_getLoginState560070384 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked4059159299 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2756365272 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2066086930 {
    NSLog(@"Continue");
}

- (void)sp_getMediaFailed3498756908 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting676236824 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess384980912 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1707540322 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1919257292 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1896703798 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed4068409862 {
    NSLog(@"Check your Network");
}

- (void)sp_upload3576906433 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess3434991587 {
    NSLog(@"Check your Network");
}

- (void)sp_upload708031574 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking923780024 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1504157778 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess4240223262 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2516552952 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkInfo2372645290 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess123504589 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3647000469 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess1625483594 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3177652694 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed119890453 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData717331695 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1396262045 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3988772556 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess3737610872 {
    NSLog(@"Continue");
}

- (void)sp_checkDefualtSetting1853236067 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload974334326 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess750914519 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting387574746 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1085867049 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess789690220 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess1629085071 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState3671166579 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3453199629 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed2996573359 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo3468285045 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting981409401 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1886250224 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2066448184 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3606283955 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3729100602 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess2846834466 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaData3523501160 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1436940398 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked4151901464 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked2113575009 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting2557452084 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1993579337 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess1844023004 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState3926026997 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1164757198 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1742661520 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed1109947243 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess2679952192 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1636349557 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1700874935 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking2580977897 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo937869090 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3345193823 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting1222359495 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess4127168982 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2204114791 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked516258055 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3235626455 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo3252810445 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess873830360 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2427236180 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState3682552521 {
    NSLog(@"Check your Network");
}

- (void)sp_checkDefualtSetting3715043717 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2168606889 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData369985097 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed283114530 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload4293578222 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1789212783 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1915412893 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData3688561369 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName1034835664 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked4248859276 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1873039426 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName203248409 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess477122413 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaData4250424267 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2902191726 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3941665843 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess128587146 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2651463648 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData461999042 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1174131541 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess3249610363 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess2403726925 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3656576217 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1908446578 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName535420560 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3966983842 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData2265399994 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking775367427 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2138417432 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1956794120 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2552974536 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed429695922 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo2173344864 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2609589021 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3233846939 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2343737896 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess887136712 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3810950246 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking3577889063 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4211242548 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking308134470 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1263628588 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3931927339 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting3221949226 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking3390461339 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed2612715042 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess498551951 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1329246455 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked3483563279 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess2054956294 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting3156502111 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostLiked3241659734 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess1325704441 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess100729870 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed4267967909 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed3721714906 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed745243651 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed178113095 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState268532525 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo2137632731 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess202781697 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking43406081 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess994278158 {
    NSLog(@"Continue");
}

- (void)sp_getUserName1065984665 {
    NSLog(@"Get Info Success");
}

- (void)sp_didUserInfoFailed829213408 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting1841364207 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess1940130094 {
    NSLog(@"Check your Network");
}

- (void)sp_checkUserInfo1921730450 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked2257361549 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData2434382314 {
    NSLog(@"Check your Network");
}

- (void)sp_checkInfo3752781160 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess2494068858 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserFollowSuccess646507753 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked749512360 {
    NSLog(@"Continue");
}

- (void)sp_upload1355762042 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1443134147 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed2406186577 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2460271528 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3623693911 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo3439264180 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess2866553432 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo2542689842 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess678551801 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked1317916986 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1279040481 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed3499418031 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getMediaFailed2140340659 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess2877099865 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload2586336576 {
    NSLog(@"Get Info Success");
}

- (void)sp_getLoginState2235749539 {
    NSLog(@"Continue");
}

- (void)sp_didUserInfoFailed218765264 {
    NSLog(@"Check your Network");
}

- (void)sp_didUserInfoFailed2477559501 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed2409415191 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload3369455754 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess1324763645 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2320551818 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess4127679415 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess3194777645 {
    NSLog(@"Get User Succrss");
}

- (void)sp_upload1248764325 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1312918542 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData1052163085 {
    NSLog(@"Check your Network");
}

- (void)sp_upload3443788250 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkInfo794730213 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo3357517346 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1827410056 {
    NSLog(@"Continue");
}

- (void)sp_getUserName2723201554 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName2473355481 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2036700472 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking3738443990 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess39248725 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3204728103 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2359832470 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo970936414 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3143776553 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3610500273 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess372803591 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData2385591239 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess749397786 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkUserInfo2878743299 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostFollowerSuccess3162997471 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1267784527 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess2336739555 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed630869664 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess1687472619 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess3023169860 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getLoginState1086604178 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo2519337343 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking931781015 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked902344188 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLiked50750498 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess2005288650 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess1717706994 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserName643706033 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLiked3056813022 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking869737541 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkNetWorking2703879033 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkNetWorking2246224769 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess1952723899 {
    NSLog(@"Check your Network");
}

- (void)sp_getMediaFailed192469352 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess2194662259 {
    NSLog(@"Check your Network");
}

- (void)sp_checkNetWorking2649452877 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getLoginState1719406080 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkDefualtSetting2627884123 {
    NSLog(@"Continue");
}

- (void)sp_upload1990677764 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLiked409035198 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2393164549 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didGetInfoSuccess532792668 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName3556971117 {
    NSLog(@"Continue");
}

- (void)sp_checkNetWorking187708883 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLiked1917187720 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostLikedSuccess951377547 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess666981717 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaData4137300595 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess2329967689 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserName3305097243 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUsersMostFollowerSuccess869788514 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed3314535966 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didGetInfoSuccess4036881159 {
    NSLog(@"Continue");
}

- (void)sp_didGetInfoSuccess2998081506 {
    NSLog(@"Continue");
}

- (void)sp_getUserName272075946 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostFollowerSuccess3680067934 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2933297867 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo122433668 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkUserInfo4044446626 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3436746705 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1446627038 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUsersMostLikedSuccess2660507687 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess3101660851 {
    NSLog(@"Get Info Failed");
}

- (void)sp_upload1894382552 {
    NSLog(@"Get Info Failed");
}

- (void)sp_checkDefualtSetting2145396136 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed232080687 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1400247711 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed3849915126 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2166636803 {
    NSLog(@"Get Info Failed");
}

- (void)sp_didUserInfoFailed1534754022 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess3290201292 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName212010485 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3736498693 {
    NSLog(@"Check your Network");
}

- (void)sp_getUserFollowSuccess56234616 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostFollowerSuccess964209225 {
    NSLog(@"Get Info Success");
}

- (void)sp_getMediaFailed1791198935 {
    NSLog(@"Continue");
}

- (void)sp_getUserFollowSuccess4005187580 {
    NSLog(@"Check your Network");
}

- (void)sp_didGetInfoSuccess1928613180 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkInfo1858347027 {
    NSLog(@"Get Info Success");
}

- (void)sp_upload1450621771 {
    NSLog(@"Get Info Success");
}

- (void)sp_getUserName1717372760 {
    NSLog(@"Continue");
}

- (void)sp_checkInfo1159894422 {
    NSLog(@"Continue");
}

- (void)sp_getMediaData1019554952 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess1648705002 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserName2266713378 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUsersMostFollowerSuccess1683634653 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess2890200914 {
    NSLog(@"Get Info Success");
}

- (void)sp_checkUserInfo3306722322 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaData662260833 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkNetWorking1484927809 {
    NSLog(@"Check your Network");
}

- (void)sp_getUsersMostLikedSuccess936577928 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getMediaFailed2810952211 {
    NSLog(@"Get User Succrss");
}

- (void)sp_getUserFollowSuccess3847381003 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo787480437 {
    NSLog(@"Continue");
}

- (void)sp_getUsersMostLikedSuccess196984579 {
    NSLog(@"Get Info Failed");
}

- (void)sp_getUserFollowSuccess1048174302 {
    NSLog(@"Continue");
}

- (void)sp_checkUserInfo2965234647 {
    NSLog(@"Get Info Success");
}

- (void)sp_didGetInfoSuccess2973699094 {
    NSLog(@"Get User Succrss");
}

- (void)sp_didUserInfoFailed700438817 {
    NSLog(@"Check your Network");
}

- (void)sp_upload1127547354 {
    NSLog(@"Get User Succrss");
}

- (void)sp_checkDefualtSetting75648878 {
    NSLog(@"Check your Network");
}
@end
