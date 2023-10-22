///////////////////////////////////////////////////////////////////////////////////////////////////
//                                        UNIVERSAL KEY                                          //
//                                         Version 1.1                                           //
//                                     BY JULIEN COPPOLANI                                       //
//                                  julien.coppolani@gmail.com                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////

// USER-CHANGABLE PARAMETERS
NB_SIDES=4; // NUMBER OF SIDES THE SHAPE HAS (3 = TRIANGLE, 4 = SQUARE, ...)

DIAMETER_EXT=9.4; // EXTERNAL DIAMETER OF KEY IN MILLIMETERS

// DIMENSION OF THE SHAPE (triangle, square or hexagonal) IN MILLIMETERS
// THE DIMENSION OF THE SHAPE CORRESPONDS TO THE DIAMETER
// OF THE CIRCLE THAT PASSES THROUGH ALL POINTS OF THE SHAPE
// EXAMPLE : FOR A 5MM SQUARE KEY, THE DIAMETER_INT WILL BE :
// DIAMETER_INT = 5MM / COS(PI/4) = 7.07MM
// FOR A 6MM SQUARE KEY, THE DIAMETER_INT WILL BE : 8.5MM
DIAMETER_INT=7.2;

LENGTH=12; // LENGTH OF THE KEY (WITHOUT THE UPPER PART FOR GRIP)

// DO NOT MODIFY
D=DIAMETER_EXT;
Ep=D/4;

// MAIN
if ( D > DIAMETER_INT && LENGTH >= 0 && NB_SIDES >= 3)
{
	difference()
	{
		union()
		{
			cylinder(LENGTH, d=DIAMETER_EXT, $fn=15*D/ln(D));
			translate([0, 0, LENGTH])
				sphere(DIAMETER_EXT/2, $fn=15*D/ln(D));
			
			// GRIP
			translate([0, 0, LENGTH])
				rotate([90, 0, 0])
					hull()
					{
						translate([-D/3, 0, 0])
							cylinder(Ep, d=D/10, center=true);
						translate([-4*D/5, D, 0])
							cylinder(Ep, d=D, center=true, $fn=15*D/ln(D));
						translate([4*D/5, D, 0])
							cylinder(Ep, d=D, center=true, $fn=15*D/ln(D));
						translate([D/3, 0, 0])
							cylinder(Ep, d=D/10, center=true);
					}		
		}
		translate([0, 0, -1])
			rotate([0, 0, 45])
				cylinder(LENGTH, d=DIAMETER_INT, $fn=NB_SIDES);
		if (LENGTH < D/2)
			translate([0, 0, -D])
				cylinder(D, d=D*1.1);		
		// HOLES FOR FIXING
		translate([-4*D/5, 0, LENGTH+D])
			rotate([90, 0, 0])
				cylinder(D/3, d=D/2.5, center=true, $fn=6*D/ln(D));
		translate([4*D/5, 0, LENGTH+D])
			rotate([90, 0, 0])
				cylinder(D/3, d=D/2.5, center=true, $fn=6*D/ln(D));
	}
}
else
{
	echo(str("\n\nERROR : INVALID VALUES. PLEASE VERIFY INPUT PARAMETERS !\n\n"));
}