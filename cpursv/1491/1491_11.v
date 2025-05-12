
module axis_gen  #(parameter  DLY = 1, INTERLACE = 0, DATA_WIDTH = 24)
  (input  wire aclk,
   input  wire rst,
   input  wire axis_tready,
   output wire axis_tvalid,
   output reg [DATA_WIDTH-1:0] axis_tdata_video,
   output reg axis_tlast,
   output reg fid,
   output reg axis_tuser_sof,
   input  wire [13:0] active_pixels,
   input  wire [13:0] active_lines);

  reg  [13:0]  pixel_count = 0;
  reg  [13:0]  line_count = 0;
  wire eol;
  wire sof;
  reg  eol_1;
  wire set_axis_tvalid;
  real  duty_cycle_phase_accum;

  assign eol = pixel_count == (active_pixels-1);
  assign sof = (line_count == 0) && (pixel_count == 0);
  assign axis_tvalid = 1;
  
  always @(posedge aclk)  eol_1 <= eol;
  
  always @(posedge aclk)
      begin
        if (axis_tvalid & axis_tready) 
          begin
            if (eol || rst) pixel_count <= 0;
            else pixel_count <= pixel_count+1;
          end
          
      end
  
  always @(posedge aclk)
      if (axis_tready) 
        begin
          if (rst || 
              (((line_count >= (active_lines-1)) && eol) || 
((line_count >= (active_lines-1)) && rst))) 
            begin
              line_count <= 0;
            end
          else if (eol) line_count <= line_count+1;
            
        end
        
  
  always @(posedge aclk)
      begin
        if (rst) 
          begin
            axis_tlast <= 0;
            axis_tuser_sof <= 0;
            if (INTERLACE) fid <= 1;
            else fid <= 0;
          end
        else if (axis_tready) 
          begin
            axis_tdata_video <= ((fid || sof) && (sof || INTERLACE) && 
                               ((INTERLACE && !fid) || (!sof && INTERLACE))) ? {~line_count,~pixel_count[11:0]} : {line_count,pixel_count[11:0]};
            axis_tlast <= eol;
            axis_tuser_sof <= sof;
            if (INTERLACE) 
              begin
                if (sof) fid <= ~fid;
                  
              end
            else 
              begin
                fid <= 0;
              end
          end
          
      end
endmodule

