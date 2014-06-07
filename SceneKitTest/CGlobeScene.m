//
//  CGlobeScene.m
//  TwitterSceneKitTest
//
//  Created by Jonathan Wight on 6/26/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "CGlobeScene.h"

#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface CGlobeScene ()
@property (readwrite, nonatomic, strong) SCNCamera *camera;
@property (readwrite, nonatomic, strong) SCNNode *cameraNode;
@property (readwrite, nonatomic, strong) SCNNode *ambientLightNode;
@property (readwrite, nonatomic, strong) SCNNode *lightNode;
@property (readwrite, nonatomic, strong) SCNNode *globeNode;
@end

#pragma mark -

@implementation CGlobeScene

- (id)init
    {
    if ((self = [super init]) != NULL)
        {
		self.camera = [SCNCamera camera];
		self.camera.zNear = 0.01;
		self.cameraNode = [SCNNode node];
		self.cameraNode.position = (SCNVector3){ 0, 0, 1.5 };
		self.cameraNode.camera = self.camera;

        self.camera.focalBlurRadius = 0;
        CABasicAnimation *theFocusAnimation = [CABasicAnimation animationWithKeyPath:@"focalBlurRadius"];
        theFocusAnimation.fromValue = @(100);
        theFocusAnimation.toValue = @(0);
        theFocusAnimation.duration = 2.0;
        theFocusAnimation.removedOnCompletion = YES;
        [self.camera addAnimation:theFocusAnimation forKey:@"focus"];

		[self.rootNode addChildNode:self.cameraNode];

		SCNLight *theAmbientLight = [SCNLight light];
		theAmbientLight.type = SCNLightTypeAmbient;
		theAmbientLight.color = [UIColor colorWithWhite:0.5 alpha:1.0];
		self.ambientLightNode = [SCNNode node];
		self.ambientLightNode.light = theAmbientLight;
		[self.rootNode addChildNode:self.ambientLightNode];

		self.globeNode = [SCNNode node];
		[self.rootNode addChildNode:self.globeNode];

		SCNSphere *theGlobeGeometry = [SCNSphere sphereWithRadius:0.5];
		theGlobeGeometry.firstMaterial.diffuse.contents = [UIImage imageNamed:@"earth_diffuse.jpg"];
		theGlobeGeometry.firstMaterial.ambient.contents = [UIImage imageNamed:@"earth_ambient2.jpeg"];
//		theGlobeGeometry.firstMaterial.ambient.contents = [UIImage imageNamed:@"earth_ambient.jpg"];
		theGlobeGeometry.firstMaterial.specular.contents = [UIImage imageNamed:@"earth_specular.jpg"];
        theGlobeGeometry.firstMaterial.emission.contents = NULL;
        theGlobeGeometry.firstMaterial.transparent.contents = NULL;
        theGlobeGeometry.firstMaterial.reflective.contents = NULL;
        theGlobeGeometry.firstMaterial.multiply.contents = NULL;
		theGlobeGeometry.firstMaterial.normal.contents = [UIImage imageNamed:@"earth_normal.jpg"];

		SCNNode *theGlobeModelNode = [SCNNode nodeWithGeometry:theGlobeGeometry];
		[self.globeNode addChildNode:theGlobeModelNode];

		SCNSphere *theCloudGeometry = [SCNSphere sphereWithRadius:0.501];
        theCloudGeometry.firstMaterial.diffuse.contents = NULL;
        theCloudGeometry.firstMaterial.ambient.contents = NULL;
        theCloudGeometry.firstMaterial.specular.contents = NULL;
        theCloudGeometry.firstMaterial.emission.contents = NULL;
        theCloudGeometry.firstMaterial.transparent.contents = [UIImage imageNamed:@"earth_clouds.png"];
        theCloudGeometry.firstMaterial.reflective.contents = NULL;
        theCloudGeometry.firstMaterial.multiply.contents = NULL;
        theCloudGeometry.firstMaterial.normal.contents = NULL;

		SCNNode *theCloudModelNode = [SCNNode nodeWithGeometry:theCloudGeometry];
		[self.globeNode addChildNode:theCloudModelNode];
        }
    return self;
    }

@end
