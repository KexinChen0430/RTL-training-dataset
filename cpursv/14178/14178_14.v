
module FIFO1(CLK,RST_N,D_IN,ENQ,FULL_N,D_OUT,DEQ,EMPTY_N,CLR);

  parameter  width = 1;
  parameter  guarded = 1;
  input  CLK;
  input  RST_N;
  input  [width-1:0] D_IN;
  input  ENQ;
  input  DEQ;
  input  CLR;
  output FULL_N;
  output [width-1:0] D_OUT;
  output EMPTY_N;
  reg  [width-1:0] D_OUT;
  reg  empty_reg;

  assign EMPTY_N = empty_reg;
  
  initial  
  begin
    D_OUT = {(width+1)/(1+1){2'b10}};
    empty_reg = 1'b0;
  end
  assign FULL_N = !empty_reg;
  
  always @(posedge CLK)
      begin
        if (!RST_N) 
          begin
            empty_reg <= 1'b0;
          end
        else 
          begin
            if (CLR) 
              begin
                empty_reg <= 1'b0;
              end
            else if (ENQ) 
              begin
                empty_reg <= 1'b1;
              end
            else if (DEQ) 
              begin
                empty_reg <= 1'b0;
              end
              
          end
      end
  
  always @(posedge CLK)
      begin
        if (ENQ) D_OUT <= D_IN;
          
      end
  
  always @(posedge CLK)
      begin : error_checks
        reg  deqerror,enqerror;

        deqerror = 0;
        enqerror = 0;
        if (RST_N) 
          begin
            if (DEQ && !empty_reg) 
              begin
                deqerror = 1;
                $display("Warning: FIFO1: %m -- Dequeuing from empty fifo");
              end
              
            if ((!FULL_N && (ENQ && !DEQ)) || 
                (!FULL_N && (ENQ && guarded))) 
              begin
                enqerror = 1;
                $display("Warning: FIFO1: %m -- Enqueuing to a full fifo");
              end
              
          end
          
      end
endmodule

