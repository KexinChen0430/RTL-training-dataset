
module csconvert_mono(input  en,
                      input  clk,
                      input  [7:0] din,
                      input  pre_first_in,
                      output [7:0] y_out,
                      output [7:0] yaddr,
                      output ywe,
                      output pre_first_out);

  wire  pre_first_out = pre_first_in;
  wire [7:0]  y_out = {~din[7],din[6:0]};
  reg  [7:0] yaddr;
  reg  ywe;

  
  always @(posedge clk)
      begin
        ywe <= (pre_first_in || 
(((yaddr[7:0] != 8'hff) || pre_first_in) && ywe)) & en;
        if (pre_first_in || 
            ((ywe && ((yaddr[7:0] != 8'hff) && pre_first_in)) || 
!en)) 
          begin
            yaddr[7:0] <= 8'h0;
          end
        else if (ywe) 
          begin
            yaddr[7:0] <= 1+yaddr[7:0];
          end
          
      end
endmodule

