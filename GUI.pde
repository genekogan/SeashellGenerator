// to-do: get rid of k, use minang/maxang

// spiral parameters
int D = 1; //varying this stretches and compresses along an axis orthoganal to the "A" parameter
float turns = 6 * TWO_PI;

float alpha = 1.49;
float beta = .47;
float A = 0;
float k = 0.86; // test variable for rate of growth

// ellipse orientation parameters
float mu = .08; // angle given in radians
float omega = .01; // angle given in radians
float phi = 2.6; //rotation of elipse about normal axis, angle given in radians

// ellipsoid parameters
float a = 13.13; //elipse radii
float b = 20; //elipse radii

// surface parameters
float L = 5;
float P = 5;
float W1 = 5;
float W2 = .39;
int N = 10;

// render mode
boolean renderSpine = false;
boolean renderMesh = true;

// display options
int GUI_SPIRAL_X = 10;          int GUI_SPIRAL_Y = 310;
int GUI_ELLIPSE_X = 10;         int GUI_ELLIPSE_Y = 410;
int GUI_ORIENTATION_X = 10;     int GUI_ORIENTATION_Y = 470;
int GUI_SURFACE_X = 10;         int GUI_SURFACE_Y = 545;
int GUI_COIL_X = 10;            int GUI_COIL_Y = 655;
int GUI_MODE_X = 10;            int GUI_MODE_Y = 10;
int GUI_UPDATE_X = 150;         int GUI_UPDATE_Y = 10;
int GUI_WIREFRAME_X = 150;      int GUI_WIREFRAME_Y = 70;
int GUI_COLORS_X = 10;          int GUI_COLORS_Y = 110;
int GUI_PRESETS_X = 10;         int GUI_PRESETS_Y = 210;


void setupGUI() 
{
  gui = new ControlP5(this);
  gui.setAutoDraw(false);
  gui.setFont(createFont("Georgia", 11), 11);

  // labels
  gui.addTextlabel("spiral")       .setText("Spiral") 
      .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y)  
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("ellipseRadii") .setText("Ellipse radii") 
      .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y) 
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("orientation")  .setText("Orientation") 
      .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y) 
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("surface")      .setText("Surface") 
      .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y) 
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("coil_")     .setText("Coil") 
      .setPosition(GUI_COIL_X, GUI_COIL_Y) 
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("presetslabel") .setText("Presets") 
      .setPosition(GUI_PRESETS_X, GUI_PRESETS_Y) 
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("colors") .setText("Color") 
      .setPosition(GUI_COLORS_X, GUI_COLORS_Y) 
      .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("livemode") .setText("Mode") 
      .setPosition(GUI_MODE_X, GUI_MODE_Y) 
      .setColorValue(0xffffff00);
      
  // bang to update mesh
  gui.addBang("bang")  .setPosition(GUI_UPDATE_X, GUI_UPDATE_Y)  
      .setSize(40, 40)  .setTriggerEvent(Bang.RELEASE)  .setLabel("update");

  // spiral
  gui.addSlider("turns")   .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+15)        .setRange(0, 10 * TWO_PI)   .setAutoUpdate(true);
  gui.addSlider("A")       .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+30)        .setRange(0, 100)           .setAutoUpdate(true);
  gui.addSlider("alpha")   .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+45)        .setRange(0, PI)            .setAutoUpdate(true);
  gui.addSlider("beta")    .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+60)        .setRange(-PI, PI)          .setAutoUpdate(true);
  gui.addSlider("k")       .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+75)        .setRange(0, 2)             .setAutoUpdate(true);

  // ellipse radius
  gui.addSlider("a")       .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y+15)       .setRange(0, 50)      .setAutoUpdate(true);
  gui.addSlider("b")       .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y+30)       .setRange(0, 50)      .setAutoUpdate(true);

  // ellipse orientation
  gui.addSlider("mu")      .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+15)       .setRange(0, TWO_PI)  .setAutoUpdate(true);
  gui.addSlider("omega")   .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+30)       .setRange(0, TWO_PI)  .setAutoUpdate(true);
  gui.addSlider("phi")     .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+45)       .setRange(-PI, PI)    .setAutoUpdate(true);

  // surface
  gui.addSlider("L")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+15)       .setRange(0, 5)       .setAutoUpdate(true);
  gui.addSlider("P")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+30)       .setRange(0, 5)       .setAutoUpdate(true);
  gui.addSlider("W1")      .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+45)       .setRange(-5, 5)      .setAutoUpdate(true);
  gui.addSlider("W2")      .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+60)       .setRange(-10, 10)    .setAutoUpdate(true);
  gui.addSlider("N")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+75)       .setRange(-10, 10)    .setAutoUpdate(true)   .setNumberOfTickMarks(10);

  // coil parameter
  gui.addRadioButton("coil")
     .setPosition(GUI_COIL_X, GUI_COIL_Y+15)
     .setSize(20,20)
     .setColorForeground(color(120))
     .setColorActive(color(255))
     .setColorLabel(color(255))
     .setItemsPerRow(1)
     .addItem("dextral",1)
     .addItem("sinistral",2);

  // presets
  String[] presetNames = new String[] {
    "BoatEarMoon", "HorseConch", "Troques", "Cone", 
    "PreciousWentleTrap", "NeptuneCarved", "Ancilla", 
    "Conch", "Barrell", "OstrichFoot", "SerpentineConch", "Lapa", 
    "SnailShell", "ShellHelmetHungarian" };

  DropdownList presets = gui.addDropdownList("list-presets");
    presets.setPosition(GUI_PRESETS_X, GUI_PRESETS_Y+30);
    for (int i = 0; i < presetNames.length; i++)
      presets.addItem(presetNames[i], i);
    presets.captionLabel().set("presets");
    presets.setItemHeight(20);
    presets.setBarHeight(15);
    presets.setWidth(200);
    presets.captionLabel().style().marginTop = 3;
    presets.captionLabel().style().marginLeft = 3;
    presets.valueLabel().style().marginTop = 3;
    presets.setColorBackground(color(60));
    presets.setColorActive(color(255, 128));

  // color picker
  gui.addColorPicker("picker")  
     .setPosition(GUI_COLORS_X, GUI_COLORS_Y+15)
     .setColorValue(color(255, 128, 0, 128));

  // live mode
  gui.addRadioButton("mode")
     .setPosition(GUI_MODE_X, GUI_MODE_Y+15)
     .setSize(20,20)
     .setColorForeground(color(120))
     .setColorActive(color(255))
     .setColorLabel(color(255))
     .setItemsPerRow(1)
     .addItem("live",0)
     .addItem("normal",1)
     .addItem("hi-res (slow)",2);
 
  // wireframe toggle
  gui.addCheckBox("wire")
    .setPosition(GUI_WIREFRAME_X, GUI_WIREFRAME_Y)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(30, 30)
    .setItemsPerRow(3)
    .setSpacingColumn(50)
    .setSpacingRow(20)
    .addItem("wireframe", 0);
    
  // export to STL
  PFont font = createFont("arial",12);
  gui.addTextfield("meshName")
   .setPosition(width-120,10)
   .setSize(100,20)
   .setText("MyShell")
   .setFont(font)
   .setFocus(true)
   .setColor(color(255,0,0));

  gui.addBang("export")
    .setPosition(width-120, 60)
    .setSize(40, 40);

  gui.addBang("export_hi_res")
    .setPosition(width-120, 130)
    .setSize(40, 40);
}

// color picker
void picker(int col) {
  meshFillColor = col;
}

// event triggers preset
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getName().equals("coil")) {
    int choice = (int) theEvent.getValue();
    if (choice==1) {
      D = 1;
      makeMesh();
    } else if (choice==2) {
      D = -1;
      makeMesh();
    }
  }
  else if (theEvent.getName().equals("mode")) {
     mode = (int) theEvent.getValue();
     if      (mode==0) makeMesh(r0x, r0y); 
     else if (mode==1) makeMesh(r1x, r1y); 
     else if (mode==2) makeMesh(r2x, r2y);
  }
  else if (theEvent.isGroup()) {
    if (theEvent.getGroup().getName().equals("wire")) {
      if (theEvent.getGroup().getValue() == 0) {
        meshFill = !meshFill;
      }
    }
    else if (theEvent.getGroup().getName().equals("list-presets")) {
      int idxPreset = (int) theEvent.getGroup().getValue();
      if      (idxPreset== 0) BoatEarMoon();
      else if (idxPreset== 1) HorseConch();
      else if (idxPreset== 2) Turitella();
      else if (idxPreset== 3) Troques();
      else if (idxPreset== 4) Cone();
      else if (idxPreset== 5) PreciousWentleTrap();
      else if (idxPreset== 6) NeptuneCarved();
      else if (idxPreset== 7) Ancilla();
      else if (idxPreset== 8) Oliva();
      else if (idxPreset== 9) Conch();
      else if (idxPreset==10) Barrell();
      else if (idxPreset==11) OstrichFoot();
      else if (idxPreset==12) SerpentineConch();
      else if (idxPreset==13) SerpentineConch();
      else if (idxPreset==14) Lapa();
      else if (idxPreset==15) SnailShell();
      else if (idxPreset==16) ShellHelmetHungarian();
    }
  }
}

void keyPressed() {
  if (key==' ') {
    makeMesh();
  }
}

