module Start_Sensor_Actuator_G1__prevStart_G1__prevSensor_net(Start, Sensor, Actuator, G1__prevStart, G1__prevSensor);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  (* src = "/Users/tramyn/Documents/workspaces/cello_workspace/yosysRun/gc.v:8" *)
  output Actuator;
  (* src = "/Users/tramyn/Documents/workspaces/cello_workspace/yosysRun/gc.v:10" *)
  output G1__prevSensor;
  (* src = "/Users/tramyn/Documents/workspaces/cello_workspace/yosysRun/gc.v:9" *)
  output G1__prevStart;
  (* src = "/Users/tramyn/Documents/workspaces/cello_workspace/yosysRun/gc.v:7" *)
  input Sensor;
  (* src = "/Users/tramyn/Documents/workspaces/cello_workspace/yosysRun/gc.v:6" *)
  input Start;
  assign _09_ = ~Start;
  assign _10_ = ~Sensor;
  assign _00_ = ~Actuator;
  assign _01_ = ~(Sensor | Actuator);
  assign _02_ = ~(_10_ | _00_);
  assign _03_ = ~(Start | Actuator);
  assign _04_ = ~(_09_ | _00_);
  assign _05_ = ~(G1__prevSensor | _03_);
  assign _06_ = ~(_04_ | _05_);
  assign G1__prevStart = ~_06_;
  assign _07_ = ~(_02_ | _06_);
  assign G1__prevSensor = ~(_01_ | _07_);
  assign _08_ = ~(Sensor | _04_);
  assign Actuator = ~(_03_ | _08_);
endmodule