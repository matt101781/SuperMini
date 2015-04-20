//
// RAMPS Case
//


// Modified by Cpayne3d December 2014
// - adjusted for 40mm x 10mm cooling fan (like ones found at www.voxelfactory.com
// - reduced fan base height to allow fan to be spaced farther away from Ramps PCB
// - increased venting holes in width and height to allow more air flow and to open up for 40mm fan
// - increased holes sizes in USB end (usb/dc power/ramps power) to properly fit the Taurino.cc version of Mega R3 + Ramp 1.4 board.  The Taurino version also has a diode on the right side which hit the inner rails.
// - added a port hole in the wiring end to allow for Reprapdiscount LCD cables to connect into the case
// - added compile option "6" to generate mounting brackets for mounting the case to a printer eg: OrdBot or i3
// - main case body unchanged from its original design
// - Do not modify parameters unless you understand the changes. Make a backup copy of this file!


// parameters
$fn=20;
c=false;  // center True/False
th=2.0;    // rib marks on outside of case
fanh=10.0;     // miniature fan height
//length=105.0;
length=105 + fanh; // add fan height
width=65.0;
height=46.0;
fh=2.0;     // feet height
mrlh=2.0;   // Left PCB mount ridge height
mrh=2.0;    // Right PCB mount ridge height
rmh=2.0;    // PCB Rail height   
rth=th+1;   // ridge thickness
mrw=3.0;    // width
mrd=2.0;    // offset
soh=6.0;    // standoff height
ch=5.0;     // cover height
cd=5.0;     // steppercable diameter

i=3; // 1=cover1, 2=cover2, 3=case, 5= case+bracket, 6=mounting bracket

if (i==1)        { Cover1();
} else if (i==2) { Cover2();
} else if (i==3) { CaseBody();
} else if (i==4) { Test();
} else if (i==5) { bracket_test();
} else if (i==6) { hadron_bracket();
}

module Test() {
   Cover2();
   translate([0,0,8])
   CaseBody();
   translate([0,0,130])
   rotate([360,180,0])
   Cover1();
}


module bracket_test() {
  translate([0,0,8])
 // CaseBody();
rampsCaseshellonly();
   //translate([0,0,2])
   hadron_bracket();
}


module hadron_bracket() {
translate([0, 0, 2])
difference() {
  union() {
   minkowski() { cube([width + 12 , height + 12, 4], center=true); cylinder(h=5, r=4, $fn=25); } // bracket ring


  // clamp connector part 1
  translate([(height/2)+17, -8, -2]) color("Blue", 1.0) cube([11, 3, 9]);

  // clamp connector part 2
  translate([(height/2)+17, -13, -2]) color("Blue", 1.0) cube([11, 3, 9]);
 

  // big foot mount point
  translate([0, height-15.5, 13]) 
  union() {
     rotate([0, 90, 0]) rotate([0, 90, 90]) minkowski() { cube([30 , 15, 3], center=true); cylinder(h=1, r=4, $fn=25); }  // bracket big foot
   } // end union for foot
   }

  union() {
   // translate([0,0, -15]) rampsCaseshellonly();
   minkowski() { cube([width-1 , height-1 , 15], center=true); cylinder(h=1, r=4, $fn=25); } // inner core removal

	//feet
	translate( [-width/2+5,25.5, -5] )
    cube( size=[5+2,fh+1,length], center=c);
	translate( [width/2-12,25.5, -5] )
    cube( size=[5+2,fh+1,length], center=c);

  // embellishments cutout
   translate( [(-height/2 )+4, -width/2+5, -5] )
     cube([15.5, 3, 15]);

  // cut to tighten clamp
  translate([(height/2)+12, -10, -3]) cube([10, 2, 15]);

 // clamp screw hole
  translate([(height/2)+24, 0, 2]) rotate([90, 0, 0]) cylinder(h=15, r=2, $fn=20);
 
   }

 } // end difference

}  // end module


module rampsCaseshellonly() {
	//case
   roundedDuct([67,48,length], 4);

	//feet
	translate( [-width/2+6,25.5,0] )
    cube( size=[5,fh,length], center=c);
	translate( [width/2-11,25.5,0] )
    cube( size=[5,fh,length], center=c);

	//embellishment
	for ( z = [0:1:5] ) {
		translate( [-5-z*1.25*th,-height/2-1.5*th,0] ) cylinder( r=th/2, h=length, center=c);
	}

}


module Cover1() {
   difference() {
 	  union() {
	    rampsCover();
	    translate([-9,0,th]) //Fan standoff
       fanmount();
	  }


      //Cableroom row2 (stepper/min/max/heater/hbp)
 	  translate( [20.5,-13,0] )
       rounded_slit(cd,2.5*cd,2*th);
	  
	  //Cableroom (reprapdiscount lcd wires)
      translate( [20,-4,0] )
       cube([cd *2, 4*cd, 2*th]); 
         //rounded_slit(cd*2.6,cd,2*th);

	  //Ventilation slits
	  for ( y = [-4.5:3.5:30] ) {
		   translate( [-10,12-y,0] )
         rounded_slit(1.5,35,2*th);
	  }
	}
}


module Cover2() {
   difference() {
	  mirror() rampsCover();
	  //USB (12x11)
	  translate( [-13.5,10.75,0] )
     cube( size=[13,11.5,2*th], center=true );
	  //Powerjack (9x11)
	  translate( [16,10.25,0] )
     cube( size=[10,11.5,2*th], center=true );
	  //Powerconnector (21x9)
	  translate( [18,-2,0] )
     cube( size=[22,10,30], center=true );
     //Connector tabs
     translate( [13,-7,0] )
     cube( size=[2.5,4,30], center=true );
     translate( [24,-7,0] )
     cube( size=[2.5,4,30], center=true );
     // Ramps PCB Edge Clearance
     translate( [27.5,2.5,5] )
     cube( size=[10,4,5], center=true );
     translate( [-27.5,2.5,5] )
     cube( size=[10,4,5], center=true );
	  //Ventilation slits
	  for ( y = [0:3.5:20] ) {
			translate( [-15,-18+y,0] ) rounded_slit(1.5,24,2*th);
	  }
  }
}

module CaseBody() {
   difference() {
     union() {
	  rampsCase();
     }
   //Reset Button Access Hole
   translate( [32.5, -2,  33])
   rotate ([0,90,0])
   cylinder( h=4,d1=4,d2=4,center=c);
   };
}

module rampsCase() {
	//case
   roundedDuct([67,48,length], 4);
	//PCB mount ridge left
	
     // original version
//	  translate( [23, 18, 9] )
//       cube( size=[9.5,3,length -18], center=c);
    // fixed version
	translate( [23, 18, 9] )
      color("red") cube( size=[10.5,3,length -18], center=c);
 
     // original version
//   translate( [23,12.5,9] )
//      cube( size=[9.5,3,length -18], center=c);
   // fixed version
   translate( [23,12.5,9] )
      color("red") cube( size=[10.5,3,length -18], center=c);

     // original version
//    translate( [26,15.5,9] )
//      cube( size=[7,3,length -18], center=c);
    // fixed version
    translate( [26,15.5,9] )
      color("red") cube( size=[8,3,length -18], center=c);


     // original version
	// right
//	translate( [-32.5,18,9] ) 
//      cube( size=[4.5,3,length-18], center=c);
	// right - fixed version
	translate( [-34.5,18,9] ) 
      color("red") cube( size=[6.5,3,length-18], center=c);

     // original version
	//upper right (shortened to leave room for the reset switch)
//	translate( [-32.5,12.5,9] )
//      cube( size=[4.5,3,length-18], center=c);
    // upper right - fixed version
	translate( [-34.5,12.5,9] )
      color("red") cube( size=[6.5,3,length-18], center=c);

// Test for Mounting Cone placment
//    translate( [23, 20, 0] )
//    cube( size=[4.5,3,8], center=c);
// Test for Mounting Cone placment

	//feet
	translate( [-width/2+6,25.5,0] )
    cube( size=[5,fh,length], center=c);
	translate( [width/2-11,25.5,0] )
    cube( size=[5,fh,length], center=c);

	//embellishment
	for ( z = [0:1:5] ) {
		translate( [-5-z*1.25*th,-height/2-1.5*th,0] ) cylinder( r=th/2, h=length, center=c);
	}

	//bottom cover mount
	translate( [-width/2,height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=45 ) mountCone();
	translate( [-width/2,-height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=-45 ) mountCone();
	translate( [width/2,-height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=-135 ) mountCone();
	translate( [width/2,height/2,12]  ) rotate(v=[1,1,0], a=180) rotate( v=[0,0,1], a=135 ) mountCone();

	//top cover mount
	translate( [width/2,-height/2,length-12]  ) rotate( v=[0,0,1], a=45 ) mountCone();
	translate( [-width/2,-height/2,length-12]  ) rotate( v=[0,0,1], a=-45 ) mountCone();
	translate( [-width/2,height/2,length-12]  ) rotate( v=[0,0,1], a=-135 ) mountCone();
	translate( [width/2,height/2,length-12]  ) rotate( v=[0,0,1], a=135 ) mountCone();
}

module rampsCover() {

   roundedDuct([67,48,ch], 4);
   translate( [0,0,0] )
   roundedRect([67,48,th], 4);

// original
	//ridge
	//translate( [0,(height-rth+.7)/2,ch] ) cube( size=[width-14,rth,ch], center=true );
// fixed version
	translate( [0,(height-rth+.7)/2,ch-1] ) color("red") cube( size=[width-14,rth,ch+1.75], center=true );

// original
	//translate( [0,-(height-rth-1.3)/2,ch] ) cube( size=[width-14,rth,ch], center=true );
// fixed version
	translate( [0,-(height-rth-1.3)/2,ch-1] ) color("red") cube( size=[width-14,rth,ch+1.75], center=true );

// original
	//translate( [((width-rth)/2)-.3,0,ch] ) cube( size=[rth,height-14,ch], center=true );
// fixed version
	translate( [((width-rth)/2)-.3,0,ch-1] ) color("red") cube( size=[rth,height-14,ch+1.75], center=true );

// original
	//translate( [-((width-rth)/2)+.3,0,ch] ) cube( size=[rth,height-14,ch], center=true );

// fixed version
	translate( [-((width-rth)/2)+.3,0,ch-1] ) color("green") cube( size=[rth,height-14,ch+1.75], center=true );


	//embellishment
	for ( z = [0:1:5] ) {
		translate( [5+z*1.25*th,-height/2-1.5*th,0] ) 
        cylinder( r=th/2, h=ch, center=c);
	}

	//holes
	translate( [width/2,-height/2,-7]  ) rotate( v=[0,0,1], a=45 ) mount();
	translate( [-width/2,-height/2,-7]  ) rotate( v=[0,0,1], a=-45 ) mount();
	translate( [-width/2,height/2,-7]  ) rotate( v=[0,0,1], a=-135 ) mount();
	translate( [width/2,height/2,-7]  ) rotate( v=[0,0,1], a=135 ) mount();

}

module mountCone() {
	difference() {
		union() {
			for ( z = [0:0.5:7] ) {
				translate( [0,z/2,z] ) cylinder( r=z/2, h=1, center=c );
			}
			mount();
		}
		translate( [0,3,8] ) cylinder( r=1, h=8, center=c );
	}
}

module mount() {
	difference() {
		translate( [0,3,7] ) cylinder( r=4, h=5, center=c );
		translate( [0,3,7] ) cylinder( r=1, h=6, center=c );
	}
}

module rounded_slit(height, width, depth) {
		cube( size=[width,height,depth], center=true );
		translate( [width/2,0,0] ) cylinder( r=height/2, h=depth, center=true );
		translate( [-width/2,0,0] ) cylinder( r=height/2, h=depth, center=true );

}


module fanmount()
{
   difference() {
      roundedRect([40, 40, 1], 2);
      cylinder( r=38/2, h=3, center=1 );
   }
}

module roundedRect(size, radius)
{
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
hull()
{
// place 4 circles in the corners, with the given radius
translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
circle(r=radius);

translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
circle(r=radius);

translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
circle(r=radius);

translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
circle(r=radius);
}
}


module roundedDuct(size, radius)
{
x = size[0];
y = size[1];
z = size[2];
x2 = size[0]-4;
y2 = size[1]-4;
radius2 = 2.5;
linear_extrude(height=z) 
difference() {
hull()
  {
  // place 4 circles in the corners, with the given radius
  translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
  circle(r=radius);

  translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
  circle(r=radius);

  translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
  circle(r=radius);

  translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
  circle(r=radius);
  }
hull()
  {
  // place 4 circles in the corners, with the given radius
  translate([(-x2/2)+(radius2/2), (-y2/2)+(radius2/2), 0])
  circle(r=radius2);

  translate([(x2/2)-(radius2/2), (-y2/2)+(radius2/2), 0])
  circle(r=radius2);

  translate([(-x2/2)+(radius2/2), (y2/2)-(radius2/2), 0])
  circle(r=radius2);

  translate([(x2/2)-(radius2/2), (y2/2)-(radius2/2), 0])
  circle(r=radius2);
  }
}

}


