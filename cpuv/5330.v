module FIFOL2(CLK, RST, D_IN, ENQ, FULL_N, D_OUT, DEQ, EMPTY_N, CLR); 
parameter width = 1; 
input CLK ; 
input RST ; 
input [width - 1 : 0] D_IN; 
input ENQ; 
input DEQ; 
input CLR ; 
output FULL_N; 
output EMPTY_N; 
output [width - 1 : 0] D_OUT; 
reg full_reg; 
reg empty_reg; 
reg [width - 1 : 0] data0_reg; 
reg [width - 1 : 0] data1_reg; 
assign FULL_N = full_reg || DEQ; 
assign EMPTY_N = empty_reg ; 
assign D_OUT = data0_reg ; 
wire d0di = (ENQ && ! empty_reg ) || ( ENQ && DEQ && full_reg ) ;
wire d0d1 = DEQ && ! full_reg ;
wire d0h = ((! DEQ) && (! ENQ )) || (!DEQ && empty_reg ) || ( ! ENQ &&full_reg) ;
wire d1di = ENQ & empty_reg ;
initial
  begin
     data0_reg   = {((width + 1)/2) {2'b10}} ;
     data1_reg  = {((width + 1)/2) {2'b10}} ;
     empty_reg = 1'b0;
     full_reg  = 1'b1;
  end 
always@(posedge CLK)
  begin
     if (RST == 1)
        begin
           data0_reg <= 0 ;
           data1_reg <= 0 ;
        end
     else
       begin
           data0_reg <= d0di & D_IN | d0d1 & data1_reg | d0h & data0_reg ;
           data1_reg <= d1di ? D_IN : data1_reg ;
       end
  end 
always@(posedge CLK)
  begin
     if (RST == 1)
       begin
          empty_reg <= 0;
          full_reg  <= 1;
       end 
     else
        begin
           if (CLR)
             begin
                empty_reg <= 0;
                full_reg  <= 1;
             end 
           else if ( ENQ && ! DEQ ) 
             begin
                empty_reg <= 1;
                full_reg <= ! empty_reg ;
             end
           else if ( DEQ && ! ENQ )
             begin
                full_reg  <= 1;
                empty_reg <= ! full_reg;
             end 
        end 
  end 
always@(posedge CLK)
  begin: error_checks
     reg deqerror, enqerror ;
     deqerror =  0;
     enqerror = 0;
     if (RST == 0)
       begin
          if ( ! empty_reg && DEQ )
            begin
               deqerror =  1;
               $display( "Warning: FIFO2: %m -- Dequeuing from empty fifo" ) ;
            end
          if ( ! full_reg && ENQ && !DEQ )
            begin
               enqerror = 1;
               $display( "Warning: FIFO2: %m -- Enqueuing to a full fifo" ) ;
            end
       end
  end 
endmodule