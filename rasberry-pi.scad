use <pin_headers.scad>;
use <TextGenerator.scad>;

WIDTH = 56;
LENGTH = 85;
HEIGHT = 1.6;

METALLIC = "silver";

ETHERNET_LENGTH = 21.2;
ETHERNET_WIDTH = 16;
ETHERNET_HEIGHT = 13.3;
ETHERNET_DIMENSIONS = [ETHERNET_LENGTH, ETHERNET_WIDTH, ETHERNET_HEIGHT];

function offset_x (ledge) = LENGTH - ETHERNET_LENGTH + ledge;

module ethernet_port ()
	{ 
    ledge = 1.2;
    pcb_margin = 1.5;
    offset = [offset_x(ledge), pcb_margin, HEIGHT];

	color(METALLIC)
        translate(offset) 
            cube(ETHERNET_DIMENSIONS); 
	}

module usb ()
	{
	color("silver")
	translate([LENGTH-9.5,25,HEIGHT]) cube([17.3,13.3,16]);
	}

module composite ()
	{
	translate([LENGTH-43.6,WIDTH-12,HEIGHT])
		{
		color("yellow")
		cube([10,10,13]);
		translate([5,19,8])
		rotate([90,0,0])
		color("silver")
		cylinder(h = 9, r = 4.15);
		}
	}

module audio ()
	{
	//audio jack
	translate([LENGTH-26,WIDTH-11.5,HEIGHT])
		{
		color ([.2,.2,.7])
		cube([12,11.5,13]);
		translate([6,11.5,8])
		rotate([-90,0,0])
		color("silver")
		cylinder(h = 3.5, r = 4.15);
		}
	}

module gpio ()
	{
	//headers (uses pin_headers.scad to make the pins).
	rotate([0,0,180])
	translate([-1,-WIDTH+6,HEIGHT])
	off_pin_header(rows = 13, cols = 2);
	}

module hdmi ()
	{
	color ("yellow")
	translate ([37.1,-1,HEIGHT])
	cube([15.1,11.7,8-HEIGHT]);
	}

module power ()
	{
	translate ([-0.8,3.8,HEIGHT])
	cube ([5.6, 8,4.4-HEIGHT]);
	}

module sd ()
	{
  	color ([0,0,0])
	translate ([0.9, 15.2,-5.2+HEIGHT])
	cube ([16.8, 28.5, 5.2-HEIGHT]);
	color ([.2,.2,.7])
	translate ([-17.3,17.7,-2.9])
	cube ([32, 24, 2] );
	}

module csicamera ()
	{
	color([0,0,0])
	translate ([55,5,HEIGHT])
	cube ([5, 25,10-HEIGHT]);

	color("white")
	translate ([55,5,11-HEIGHT])
	cube ([5, 25,1]);
	}

module dsidisplay ()
	{
	color([0,0,0])
	translate ([10,15,HEIGHT])
	cube ([5, 10,10-HEIGHT]);
	color("white")
	translate ([10,15,11-HEIGHT])
	cube ([5, 10,1]);
	}

module text ()
	{
	translate ([25,25,2.6-HEIGHT])
	drawtext("R-Pi");
	}

module mounthole ()
	{
	cylinder (r=3/2, h=HEIGHT+.2, $fs=0.1);
	}


module pi()
	{
	// full Assembly

	difference ()
		{
		color([0.2,0.5,0])
		linear_extrude(height = HEIGHT)
		square([LENGTH,WIDTH]); //pcb
		translate ([25.5, 18,-0.1])
		mounthole (); 
		translate ([LENGTH-5, WIDTH-12.5, -0.1])
		mounthole (); 
		}

	ethernet_port ();
	usb ();
	composite ();
	audio ();
	gpio ();
	hdmi ();
	power ();
	sd ();
	csicamera ();
	dsidisplay ();
	text();
	}

pi();