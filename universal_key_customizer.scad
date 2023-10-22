////////////////////////////////////////////////////////////////////////////////
//                              UNIVERSAL KEY                                 //
//                               Version 1.0                                  //
//                           BY JULIEN COPPOLANI                              //
//                        julien.coppolani@gmail.com                          //
////////////////////////////////////////////////////////////////////////////////

// This version has been edited to work with thingiverse customizer

/* [General Settings] */

// IGNORE THIS PARAMETER (IT IS USED FOR CUSTOMIZER TO WORK CORRECTLY)
Test = 0; // [0,1]

// TYPE OF KEY
TYPE="square"; // [triangle,square,hexagonal]

// EXTERNAL DIAMETER OF KEY IN MILLIMETERS
DIAMETER_EXT=9.5;

// DIMENSION OF THE SHAPE (triangle, square or hexagonal) IN MILLIMETERS
DIAMETER_INT=7.3;

// LENGTH OF THE KEY (WITHOUT THE GRIP PART)
LENGTH=12;

/* [Hidden] */
D=DIAMETER_EXT;
Ep=D/4;

// MAIN
if ( D >  DIAMETER_INT )
{
	difference()
	{
		union()
		{
			cylinder(LENGTH, d=DIAMETER_EXT, $fn=15*D/ln(D));
			translate([0, 0, LENGTH])
				sphere(DIAMETER_EXT/2, $fn=15*D/ln(D));
			
			// PRISE EN MAIN
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
		if (TYPE=="triangle") {
			cylinder(LENGTH, d=DIAMETER_INT, $fn=3);
		}
		else if (TYPE=="square") {
			cylinder(LENGTH, d=DIAMETER_INT, $fn=4);
		}
		else if (TYPE=="hexagonal") {
			cylinder(LENGTH, d=DIAMETER_INT, $fn=6);
		}
		// TROUS POUR FIXATION
		translate([-4*D/5, 0, LENGTH+D])
			rotate([90, 0, 0])
				cylinder(D/3, d=D/2.5, center=true, $fn=6*D/ln(D));
		translate([4*D/5, 0, LENGTH+D])
			rotate([90, 0, 0])
				cylinder(D/3, d=D/2.5, center=true, $fn=6*D/ln(D));
	}
}
