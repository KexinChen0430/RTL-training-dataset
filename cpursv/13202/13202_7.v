
module rr_arb  #(parameter  CLIENTS = 2)
  (input  wire clk,
   input  wire reset,
   input  wire cycle,
   input  wire [(-1)+CLIENTS:0] req,
   output reg [(-1)+CLIENTS:0] gnt);

  wire active_req;
  reg  [(-1)+CLIENTS:0] previous_winner;
  wire [(CLIENTS*2)-1:0] start_array;

  assign active_req = |req && cycle;
  integer index;

  integer allowed;

  assign start_array = {{CLIENTS{1'b0}},previous_winner};
  
  always @(*)
      begin
        gnt = 0;
        if (active_req) 
          begin
            for (allowed = 0,
index = 0; index < (CLIENTS*2); index = 1+index)
                begin
                  if (start_array[index] == 1) 
                    begin
                      allowed = 1;
                    end
                    
                  if ((req[index%CLIENTS] == 1) && (allowed == 1)) 
                    begin
                      allowed = 0;
                      gnt[index%CLIENTS] = 1;
                    end
                    
                end
          end
          
      end
  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            previous_winner <= #0 1;
          end
        else 
          begin
            if (active_req) 
              begin
                previous_winner <= #0 gnt;
              end
              
          end
      end
endmodule

