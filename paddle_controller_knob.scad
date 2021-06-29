// "Paddle Controller Adapter for Mouse" is a derivative of
// [Atari 2600 Paddle Replacement Wheel](http://www.thingiverse.com/thing:21854)
// by [jtritell](https://www.thingiverse.com/jtritell/),
// used under the Creative Commons - Attribution - Share Alike license.
// 
// "Paddle Controller Adapter for Mouse" is licensed under the
// Creative Commons - Attribution - Share Alike license by Justin Wong
// 
// http://creativecommons.org/licenses/by-sa/3.0/

// Magnet
MagnetRadius = 3;
MagnetHeight = 3;

// roundness

$fa = 3;
$fs = 0.4;

// Lowest 
LowestDiameter=44.5;
LowestRadius=LowestDiameter/2;
LowestHeight=3;

// Middle 
MiddleDiameter=46.5;
MiddleRadius=MiddleDiameter/2;
MiddleHeight=7;

// Top 
TopDiameter1=47.5;
TopDiameter2=46.0;
TopRadius1=TopDiameter1/2;
TopRadius2=TopDiameter2/2;
TopHeight=13;

// Inner 
InnerDiameter= 26;// Original: 41.5;
InnerRadius=InnerDiameter/2;

// Center Post 

CenterDiameter=9;// Original: 12;
CenterRadius=CenterDiameter/2;
CenterInnerRadius=3.7; // determines fit on potentiometer

// Knurling 
Divots=45;
FilletRadius=2;


FullHeight=LowestHeight+MiddleHeight+TopHeight;



difference(){
     union(){
	  cylinder(LowestHeight,LowestRadius,LowestRadius);
	  translate([0,0,LowestHeight])
	       cylinder(MiddleHeight,MiddleRadius,MiddleRadius);
	  translate([0,0,LowestHeight+MiddleHeight])
	       cylinder(TopHeight,TopRadius1,TopRadius2);
     }

     // Knurling
     translate([0,0,LowestHeight+MiddleHeight])
	  for(i=[0 :Divots-1]){
	       rotate(i*360/Divots, [0, 0 , 1])
		    translate([0, TopRadius2-1 ,0])
		    cube([1,2,TopHeight+10]);}

     //Fillet
     filletStartRadius = TopRadius2 + (TopRadius1-TopRadius2)*(FilletRadius/TopHeight) - FilletRadius;
     translate([0,0,FullHeight-FilletRadius+0.01])
	  rotate_extrude(angle=360) {
	  translate([filletStartRadius, 0, 0])
	       difference() {
	       square(FilletRadius);
	       circle(FilletRadius);
	  }
     }
     
     // Subtract inside
     translate([0,0,-0.1])
	  cylinder(LowestHeight+MiddleHeight+TopHeight-3,InnerRadius,InnerRadius);


     // Subtract pattern on top
     translate([0,0,FullHeight-1])
	  difference(){
	  cylinder(2,19,19);
	  cylinder(2,17.75,17.75);
     }
}

// Center Post 
difference(){
     cylinder(FullHeight-1.1,CenterRadius,CenterRadius);
     translate([0,0,-0.1]) {
	  cylinder(MagnetHeight,MagnetRadius,MagnetRadius);
	  difference(){
	       // cylinder(FullHeight-1.1,CenterInnerRadius,CenterInnerRadius+0.1); 
	       // translate([-CenterRadius,CenterRadius-3.5,0]) 
	       // cube([CenterDiameter,CenterDiameter,FullHeight]); 
	  }
     }
}	  




// Center Post Supports 

// Center Post Support count
centerPostSupportCount = 6;
// Start angle for first support 
centerPostSupportOffsetAngle = 180;

translate([0,0,0])
for(i=[0:centerPostSupportCount-1])
     rotate([0,0,centerPostSupportOffsetAngle])
	  rotate(i*360/centerPostSupportCount, [0,0,1])
	  translate([-1,CenterRadius-0.5,0])
	  cube([2,InnerRadius-CenterRadius+0.6,FullHeight]);
