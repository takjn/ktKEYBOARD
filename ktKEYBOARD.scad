 
key_pitch_x = 19;
key_pitch_y = 19;
hole_x = 14;
hole_y = 14;
panel_thick = 5;

front_height = 18;
angle = 6;

gap1 = 0.01;
gap2 = gap1 * 2;

// length of side function keys
ctl_key_width = 1.5;
row0_x = ctl_key_width - 1;

// left hand
translate( [0, 0, 0] ){
    difference(){
        union(){
            // left side control keys
            for( y = [1:4] ) key( 0, y, ctl_key_width);

            // alphanumeric keys
            union(){
                for( y = [1:4] ) key( ctl_key_width + 0, y + 0 * 0.12);
                for( y = [1:4] ) key( ctl_key_width + 1, y + 1 * 0.12);
                for( y = [1:4] ) key( ctl_key_width + 2, y + 2 * 0.12);
                for( y = [1:4] ) key( ctl_key_width + 3, y + 1 * 0.12);
                for( y = [1:4] ) key( ctl_key_width + 4, y + 0 * 0.12);
            }
            
            // right side control keys
            for( y = [1:4] ) key(ctl_key_width + 5 , y-0.12);

            // bottom control keys
            key( row0_x + 0, 0 );
            key( row0_x + 1, 0 );
            key( row0_x + 2, 0 + 0.12);
            key( row0_x + 3, 0 + 0.24);
            key( row0_x + 4, 0 + 0.12);

            // space key
            fill( row0_x + 5 + 0  , -0.12, 0.5 );
            key ( row0_x + 5 + 0.5, -0.12, 1.0 );
            fill( row0_x + 5 + 1.5, -0.12, 0.5 );
            fill( row0_x + 5, 1-0.12, 1, 0.12);

            // outline
            difference(){
                // wall
                union(){
                    // upper edge
                    wall_x_left( 0, 2.5, 5);
                    wall_x( 2.5, 3.5, 5 + 0.12 );
                    wall_x( 3.5, 4.5, 5 + 0.24 );
                    wall_x( 4.5, 5.5, 5 + 0.12 );
                    wall_x( 5.5, 6.5, 5);
                    wall_x_right( 6.5, 7.5, 5 - 0.12 );

                    // bottom edge
                    wall_x_left( 0.0, 0.5, 1);
                    wall_x_left( 0.5, 2.5, 0);
                    wall_x( 2.5, 3.5, 0 + 0.12 );
                    wall_x( 3.5, 4.5, 0 + 0.24 );
                    wall_x( 4.5, 5.5, 0 + 0.12 );
                    wall_x_right( 5.5, 7.5, 0 - 0.12);

                    // left edge
                    wall_y_left( 0, 1, 5 );
                    wall_y_left( 0.5, 0, 1 );

                    // right edge
                    wall_y_right( 7.5, 0 - 0.12, 5 - 0.12 );
                    wall_y( 5.5, 0 - 0.12, 0.5 );

//                    // supporter wall
//                    wall_y( 4.5, 3, 4 );
//                    wall_y( 2.5, 2, 3 );
                }
                // cable hole
                translate( [key_pitch_x*7.5, key_pitch_y*3.95, -14] ){
                    rotate([-angle,0,0]) {
                        cube( [panel_thick, 32, 3], center=true );
                    }
                }
            }
        }
        
        rotate( a=-angle, v=[1, 0, 0] )
        translate( [-key_pitch_x*3, -key_pitch_y*5, -front_height-42] )
        cube( [key_pitch_x*13, key_pitch_y*13, 50] );
    }
}

module key( x, y, w=1 ){
    translate( [key_pitch_x*x + key_pitch_x/2 + key_pitch_x*(w - 1)/2, key_pitch_y*y + key_pitch_y/2, -(panel_thick/2)] ){
        difference(){
            cube( [key_pitch_x*w, key_pitch_y, panel_thick], center=true ) ;
            cube( [hole_x, hole_y, panel_thick + gap2], center=true );
            translate( [0, -hole_y/2, panel_thick/2 - 1.5] )
            claw();
            translate( [0, hole_y/2, panel_thick/2 - 1.5] )
            rotate( [0, 0, 180] )
            claw();
            translate( [0, 0, panel_thick + 2] )
            rotate( [180, 0, 45] )
            cylinder( hole_y*1.1, hole_y*1.1, 0, $fn=4 );
        }
    }
}
module claw(){
    translate( [-2, -1, -1] ){
        difference(){
            union(){
                cube( [4, 2, 1] );
                rotate( [-45, 0, 0] )
                cube( [4, 2, 1] );
            }
            translate( [-gap1, 1+gap1, -2-gap1] )
            cube( [4+gap2, 2, 3+gap2] );
        }
    }
}

module fill( x, y, w, h=1){
    translate( [key_pitch_x*x + key_pitch_x/2 +key_pitch_x*(w - 1)/2, key_pitch_y*y + key_pitch_y/2+key_pitch_y*(h - 1)/2, -(panel_thick/2)] ){
        cube( [key_pitch_x*w, key_pitch_y*h, panel_thick], center=true ) ;
    }
}

module wall_x( x1, x2, y ){
    translate( [key_pitch_x*x1 - ((key_pitch_x - hole_x)/2)/2, key_pitch_y*y - ((key_pitch_y - hole_y)/2)/2, -50] )
    cube( [key_pitch_x*(x2 - x1) + ((key_pitch_x - hole_x)/2), (key_pitch_y - hole_y)/2, 50] );
}

module wall_x_left( x1, x2, y ){
    translate( [key_pitch_x*x1, key_pitch_y*y - ((key_pitch_y - hole_y)/2)/2, -50] )
    cube( [key_pitch_x*(x2 - x1) + ((key_pitch_x - hole_x)/2)/2, (key_pitch_y - hole_y)/2, 50] );
}

module wall_x_right( x1, x2, y ){
    translate( [key_pitch_x*x1 - ((key_pitch_x - hole_x)/2)/2, key_pitch_y*y - ((key_pitch_y - hole_y)/2)/2, -50] )
    cube( [key_pitch_x*(x2 - x1) + ((key_pitch_x - hole_x)/2)/2, (key_pitch_y - hole_y)/2, 50] );
}

module wall_y( x, y1, y2 ){
    translate( [key_pitch_x*x - ((key_pitch_x - hole_x)/2)/2, key_pitch_y*y1, -50] )
    cube( [(key_pitch_x - hole_x)/2, key_pitch_y*(y2 - y1), 50] );
}


module wall_y_left( x, y1, y2 ){
    translate( [key_pitch_x*x , key_pitch_y*y1, -50] )
    cube( [(key_pitch_x - hole_x)/2, key_pitch_y*(y2 - y1), 50-panel_thick] );
}

module wall_y_right( x, y1, y2 ){
    translate( [key_pitch_x*x - ((key_pitch_x - hole_x)/2), key_pitch_y*y1, -50] )
    cube( [(key_pitch_x - hole_x)/2, key_pitch_y*(y2 - y1), 50-panel_thick] );
}

