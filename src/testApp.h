#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxOsc.h"

#define HOST "192.168.60.17"//"localhost"
#define PORT 12345

class testApp : public ofxiPhoneApp {

	public:
		void setup();
		void update();
		void draw();
		void exit();
		
		void touchDown(ofTouchEventArgs &touch);
		void touchMoved(ofTouchEventArgs &touch);
		void touchUp(ofTouchEventArgs &touch);
		void touchDoubleTap(ofTouchEventArgs &touch);
		void touchCancelled(ofTouchEventArgs &touch);

		void lostFocus();
		void gotFocus();
		void gotMemoryWarning();
		void deviceOrientationChanged(int newOrientation);

    void changeHost(string h);
  
		ofxOscSender sender;
    ofPoint      mTouch;
    bool         bTouchDown;
  
    float lengthRatio;
    int numPoints;
    bool bFill;
    string host;
};

