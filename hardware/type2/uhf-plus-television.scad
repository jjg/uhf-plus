// TODO: Get actual measurements of the LCD
LCD_LENGTH = 165;   // just a guess
LCD_WIDTH = 107;    // just a guess
LCD_DEPTH = 5;      // just a guess

// replace CARD with LCD
CARD_LENGTH = LCD_WIDTH; //LCD_LENGTH; //51;
CARD_WIDTH = LCD_WIDTH; //51;
CARD_DEPTH = LCD_DEPTH; //3;

BORDER = 3;
KNOB_DIAMETER = 20;
KNOB_SHAFT_DIAMETER = 10;
KNOB_POCKET_DIAMETER = 42;

BACK = true;
KNOBS = true;
KNOB_POCKETS = false;

difference(){
    
    // Console
    union(){
        // front
        cube([CARD_LENGTH+(BORDER*2), CARD_WIDTH+(BORDER*2), CARD_DEPTH*3]);
        
        // back
        if(BACK){
            translate([0,0,-100]){
                difference(){
                    cube([LCD_LENGTH+(BORDER*2), LCD_WIDTH+(BORDER*2), 100]);
                    translate([BORDER,BORDER,BORDER]){
                        cube([LCD_LENGTH,LCD_WIDTH,100-BORDER]);
                    }
                }
            }
        }
    }
    
    translate([BORDER,BORDER,-1]){
        // overall screen cutout
        cube([CARD_LENGTH,CARD_WIDTH,CARD_DEPTH*4]);
    }
}

// Frame corners
translate([0,0,0]){
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
            // TODO: replace speaker with pattern (real speakers will be on the sides)
            translate([(((LCD_LENGTH-LCD_WIDTH)-(BORDER))/2)-(((CARD_LENGTH/3)-BORDER*2.5)/2),(CARD_WIDTH-BORDER)-(KNOB_DIAMETER*8),-BORDER]){
                cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                translate([0,-2,0]){
                    cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                    translate([0,-2,0]){
                        cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                        translate([0,-2,0]){
                            cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                            translate([0,-2,0]){
                                cube([(CARD_LENGTH/3)-BORDER*2.5,1,BORDER]);
                            }
                        }
                    }
                }
            }
        }
        
        // knob pockets & shaft holes
        if(KNOB_POCKETS){
            translate([((LCD_LENGTH-LCD_WIDTH)/2),CARD_WIDTH-(KNOB_DIAMETER/2)-(BORDER*2),-1]){
                cylinder(r=KNOB_POCKET_DIAMETER/2,h=BORDER*2,$fn=35);
                cylinder(r=KNOB_SHAFT_DIAMETER/2,h=CARD_DEPTH*3);
                translate([0,-KNOB_DIAMETER*2,0]){
                    cylinder(r=KNOB_POCKET_DIAMETER/2,h=BORDER*2,$fn=35);
                    cylinder(r=KNOB_SHAFT_DIAMETER/2,h=CARD_DEPTH*3);
                }
            }
        }
    }
    
    // knobs
    if(KNOBS){
        translate([((LCD_LENGTH-LCD_WIDTH)/2),CARD_WIDTH-(KNOB_DIAMETER/2)-(BORDER*2),(CARD_DEPTH*2)+BORDER-1.5]){
            cylinder(r=KNOB_DIAMETER/2,h=BORDER*2,$fn=35);
            translate([0,-KNOB_DIAMETER*2,0]){
                cylinder(r=KNOB_DIAMETER/2,h=BORDER*2,$fn=35);
            }
        }
    }
}
