#include "testApp.h"
#include "MyGuiView.h"

MyGuiView * myGuiViewController;

//--------------------------------------------------------------
void testApp::setup(){
	//ofSetOrientation(OF_ORIENTATION_90_LEFT);

	ofBackground( 40, 100, 40 );

	
  
  bTouchDown = false;
  
  //Our Gui setup
	myGuiViewController	= [[MyGuiView alloc] initWithNibName:@"MyGuiView" bundle:nil];
	[ofxiPhoneGetUIWindow() addSubview:myGuiViewController.view];
  
  host = "192.168.60.17";
  // open an outgoing connection to HOST:PORT
	sender.setup( host, PORT );
}

//--------------------------------------------------------------
void testApp::update(){
	//we do a heartbeat on iOS as the phone will shut down the network connection to save power
	//this keeps the network alive as it thinks it is being used. 
	if (bTouchDown){
    ofxOscMessage m;
    m.setAddress( "/mouse/position" );
    m.addIntArg( mTouch.x );
    m.addIntArg( mTouch.y );
    sender.sendMessage( m );
  }
  else if( ofGetFrameNum() % 120 == 0 ){
		ofxOscMessage m;
		m.setAddress( "/misc/heartbeat" );
		m.addIntArg( ofGetFrameNum() );
		sender.sendMessage( m );
	} 
}

//--------------------------------------------------------------
void testApp::draw(){
	// display instructions
	string buf;
	buf = "sending osc messages to" + string( HOST ) + ofToString( PORT );
	ofDrawBitmapString( buf, 10, 20 );
	ofDrawBitmapString( "move the mouse to send osc message [/mouse/position <x> <y>]", 10, 50 );
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::changeHost(string h){
  if (h != host){
    host = h;
    sender.setup(host, PORT);
    cout << "Changed host to " << h << endl;
  }
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
	ofxOscMessage m;
	m.setAddress( "/mouse/touchdown" );
  m.addIntArg( touch.x );
	m.addIntArg( touch.y );
	sender.sendMessage( m );
  mTouch.x = touch.x;
  mTouch.y = touch.y;
  bTouchDown = true;
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
	ofxOscMessage m;
	m.setAddress( "/mouse/position" );
	m.addIntArg( touch.x );
	m.addIntArg( touch.y );
	sender.sendMessage( m );
  mTouch.x = touch.x;
  mTouch.y = touch.y;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
	ofxOscMessage m;
  m.setAddress( "/mouse/touchup" );
  m.addIntArg( touch.x );
	m.addIntArg( touch.y );
	sender.sendMessage( m );
  bTouchDown = false;
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
  //IF THE VIEW IS HIDDEN LETS BRING IT BACK!
	if( myGuiViewController.view.hidden ){
		myGuiViewController.view.hidden = NO;
	}
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

