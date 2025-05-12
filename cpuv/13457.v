module cnt
  #(parameter width=32, 
    parameter direction=`CNT_UP) 
  (input clk, 
   input [width-1:0] top, 
   input rstn, 
   input clr_it, 
   input start, 
   input freerun, 
   output reg [width-1:0] cnt, 
   output reg it); 
  wire [width-1:0] one; 
  wire [width-1:0] zero; 
  wire [width-1:0] load; 
  wire [width-1:0] tgt; 
  wire [width-1:0] inc; 
  assign one = {{width-1{1'b0}}, 1'b1}; 
  assign zero = {width{1'b0}}; 
  assign load = (direction == `CNT_UP)?zero:top; 
  assign tgt = (direction == `CNT_UP)?top:zero; 
  assign inc = (direction == `CNT_UP)?one:-one; 
  reg ovf; 
  reg run; 
  always @(posedge clk) begin 
    if (~rstn || ~clr_it) 
      it <= 1'b0; 
    else if (ovf) 
      it <= 1'b1; 
  end
  always @(posedge clk) begin 
    if (~rstn) begin 
      ovf <= 1'b0; 
      cnt <= load; 
      run <= 1'b0; 
    end else if (~run & start) begin 
      run <= 1'b1; 
    end else begin
      if (run) 
        cnt <= cnt + inc; 
      if (cnt == tgt) begin 
        ovf <= 1'b1; 
        cnt <= load; 
        if (~freerun) 
          run <= 1'b0; 
      end else
        ovf <= 1'b0; 
    end
  end
endmodule