module outputs
  wire [16 : 0] pixelect;
  wire RDY_hsync,
       RDY_pixelect,
       RDY_stack_en,
       RDY_video_en,
       RDY_vsync,
       hsync,
       stack_en,
       video_en,
       vsync;
  assign pixelect = 17'd12 ;
  assign RDY_pixelect = 1'd1 ;
  assign hsync = 1'd1 ;
  assign RDY_hsync = 1'd1 ;
  assign vsync = 1'd1 ;
  assign RDY_vsync = 1'd1 ;
  assign video_en = 1'd1 ;
  assign RDY_video_en = 1'd1 ;
  assign stack_en = 1'd1 ;
  assign RDY_stack_en = 1'd1 ;
endmodule