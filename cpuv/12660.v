module var7_multi(A, B, C, D, E, F, G, valid); 
  wire _000_; 
  wire _001_; 
  wire _002_; 
  wire _003_; 
  wire _004_; 
  wire _005_; 
  wire _006_; 
  wire _007_; 
  wire _008_; 
  wire _009_; 
  wire _010_; 
  wire _011_; 
  wire _012_; 
  wire _013_; 
  wire _014_; 
  wire _015_; 
  wire _016_; 
  wire _017_; 
  wire _018_; 
  wire _019_; 
  wire _020_; 
  wire _021_; 
  wire _022_; 
  wire _023_; 
  wire _024_; 
  wire _025_; 
  wire _026_; 
  wire _027_; 
  wire _028_; 
  wire _029_; 
  wire _030_; 
  wire _031_; 
  wire _032_; 
  wire _033_; 
  wire _034_; 
  wire _035_; 
  wire _036_; 
  wire _037_; 
  wire _038_; 
  wire _039_; 
  wire _040_; 
  wire _041_; 
  wire _042_; 
  wire _043_; 
  wire _044_; 
  wire _045_; 
  wire _046_; 
  wire _047_; 
  wire _048_; 
  wire _049_; 
  wire _050_; 
  wire _051_; 
  wire _052_; 
  wire _053_; 
  wire _054_; 
  wire _055_; 
  wire _056_; 
  wire _057_; 
  wire _058_; 
  wire _059_; 
  wire _060_; 
  wire _061_; 
  wire _062_; 
  wire _063_; 
  wire _064_; 
  input A; 
  input B; 
  input C; 
  input D; 
  input E; 
  input F; 
  input G; 
  output valid; 
  assign _064_ = A & D; 
  assign _000_ = _064_ ^ B; 
  assign _001_ = _000_ ^ E; 
  assign _002_ = ~F; 
  assign _003_ = A ^ D; 
  assign _004_ = ~(_003_ | _002_); 
  assign _005_ = _004_ ^ _001_; 
  assign _006_ = ~(_005_ & G); 
  assign _007_ = _000_ & E; 
  assign _008_ = ~(A & B); 
  assign _009_ = ~(_008_ & D); 
  assign _010_ = _009_ ^ _007_; 
  assign _011_ = ~((_003_ | _001_) & F); 
  assign _012_ = ~(_011_ ^ _010_); 
  assign _013_ = _003_ ^ F; 
  assign _014_ = _013_ | E; 
  assign _015_ = ~((_014_ & _005_) | G); 
  assign _016_ = ~((_015_ | _012_) & _006_); 
  assign _017_ = ~E; 
  assign _018_ = C & D; 
  assign _019_ = _018_ ^ A; 
  assign _020_ = C | D; 
  assign _021_ = _020_ & E; 
  assign _022_ = ~(_021_ & _019_); 
  assign _023_ = ~(A ^ B); 
  assign _024_ = ~C; 
  assign _025_ = ~(_064_ | _024_); 
  assign _026_ = _025_ ^ _023_; 
  assign _027_ = ~((_026_ | _017_) & _022_); 
  assign _028_ = ~A; 
  assign _029_ = _028_ & B; 
  assign _030_ = _028_ | B; 
  assign _031_ = ~((_030_ & _024_) | _029_); 
  assign _032_ = ~(_064_ | _018_); 
  assign _033_ = ~((_032_ | B) & (_031_ | D)); 
  assign _034_ = _033_ ^ _017_; 
  assign _035_ = ~(_034_ ^ _027_); 
  assign _036_ = _021_ | _019_; 
  assign _037_ = _022_ & E; 
  assign _038_ = ~(_037_ ^ _026_); 
  assign _039_ = ~((_036_ & _022_) | _038_); 
  assign _040_ = ~(_039_ & _035_); 
  assign _041_ = _018_ & A; 
  assign _042_ = ~(A | B); 
  assign _043_ = ~((_042_ | _024_) & _008_); 
  assign _044_ = ~((_031_ & D) | _043_); 
  assign _045_ = ~((_044_ | _041_) & (_033_ | _017_)); 
  assign _046_ = ~((_034_ & _027_) | _045_); 
  assign _047_ = ~(_046_ | _002_); 
  assign _048_ = A & B; 
  assign _049_ = ~((_007_ | _048_) & D); 
  assign _050_ = ~((_011_ | _010_) & _049_); 
  assign _051_ = _048_ & _020_; 
  assign _052_ = ~(C & D); 
  assign _053_ = ~(_020_ & _052_); 
  assign _054_ = ~G; 
  assign _055_ = ~(_023_ & _054_); 
  assign _056_ = ~((_055_ | _053_) & _051_); 
  assign _057_ = ~((_042_ | _002_) & _056_); 
  assign _058_ = ~(_023_ | G); 
  assign _059_ = ~((_058_ & _053_) | (_008_ & _052_)); 
  assign _060_ = ~((_059_ & _057_) | _041_); 
  assign _061_ = _060_ & _050_; 
  assign _062_ = ~(_061_ & _022_); 
  assign _063_ = ~((_047_ & _040_) | _062_); 
  assign valid = _063_ & _016_; 
endmodule 