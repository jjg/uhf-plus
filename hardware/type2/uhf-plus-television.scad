// TODO: Get actual measurements of the LCD
LCD_LENGTH = 165;   // just a guess
LCD_WIDTH = 107;    // just a guess
LCD_DEPTH = 5;      // just a guess

// replace CARD with LCD
CARD_LENGTH = LCD_WIDTH; //LCD_LENGTH; //51;
CARD_WIDTH = LCD_WIDTH; //51;
CARD_DEPTH = LCD_DEPTH; //3;

BORDER = 3;
KNOB_DIAMETER = 10;

difference(){
    
    // Console
    union(){
        cube([CARD_LENGTH+(BORDER*2), CARD_WIDTH+(BORDER*2), CARD_DEPTH*3]);
        
        translate([0,0,-100]){
            cube([LCD_LENGTH+(BORDER*2), LCD_WIDTH+(BORDER*2), 100]);
        }
    
        /*
        // This is a lazy way to make it thicker but will work for now
        translate([0,0,-CARD_DEPTH*3]){
            #cube([CARD_LENGTH+(BORDER*2), CARD_WIDTH+(BORDER*2), CARD_DEPTH*3]);
            translate([CARD_LENGTH+BORDER,0,0]){
                #cube([CARD_LENGTH/3, CARD_WIDTH+(BORDER*2), CARD_DEPTH*3]);
            }
        }
        */
    
    }
    
    /*
    // Card opening
    translate([0,BORDER,BORDER]){
        #cube([CARD_LENGTH,CARD_WIDTH,CARD_DEPTH]);
    }
    */
    
    translate([BORDER,BORDER,-1]){
    
        // overall screen cutout
        cube([CARD_LENGTH,CARD_WIDTH,CARD_DEPTH*4]);

        // Frame cutout
        translate([0,0,CARD_DEPTH]){
            cube([CARD_LENGTH,CARD_WIDTH,CARD_DEPTH*2]);
        }
        
        // LCD cutout
        cube([LCD_LENGTH, LCD_WIDTH, LCD_DEPTH]);
    }
}

// Frame corners
translate([0,0,CARD_DEPTH]){
    difference(){
        cube([CARD_LENGTH+(BORDER*2), CARD_WIDTH+(BORDER*2), CARD_DEPTH+1]);
        translate([BORDER,BORDER,0]){
            // View cutout            
            translate([CARD_LENGTH/2,CARD_LENGTH/2,-1]){
                cylinder(r=CARD_LENGTH/1.5,h=CARD_DEPTH+3,$fn=50);
            }            
        }
    }
}

// Controls
translate([CARD_LENGTH+BORDER,0,0]){
    difference(){
        cube([LCD_LENGTH-LCD_WIDTH+BORDER, CARD_WIDTH+(BORDER*2), CARD_DEPTH*3]);
        
        // Frame cutout
        translate([BORDER,BORDER,(CARD_DEPTH*2)+BORDER-1]){
            cube([(LCD_LENGTH-LCD_WIDTH)-(BORDER),CARD_WIDTH,CARD_DEPTH]);
            
            // Speaker grille
            translate([(((LCD_LENGTH-LCD_WIDTH)-(BORDER))/2)-(((CARD_LENGTH/3)-BORDER*2.5)/2),(CARD_WIDTH-BORDER)-(KNOB_DIAMETER*8),-BORDER]){
                #cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                translate([0,-2,0]){
                    #cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                    translate([0,-2,0]){
                        #cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                        translate([0,-2,0]){
                            #cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                            translate([0,-2,0]){
                                #cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Knobs
    translate([((LCD_LENGTH-LCD_WIDTH)/2),CARD_WIDTH-(KNOB_DIAMETER/2)-(BORDER*2),(CARD_DEPTH*2)+BORDER-1.5]){
        cylinder(r=KNOB_DIAMETER,h=BORDER,$fn=25);
        translate([0,-KNOB_DIAMETER*3,0]){
            cylinder(r=KNOB_DIAMETER,h=BORDER,$fn=25);
        }
    }
}
