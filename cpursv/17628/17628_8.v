
module by_width(input  clk);

  parameter  WIDTH = 1;
  reg  signed  i1;
  reg  signed  [62:0] i63;
  reg  signed  [64:0] i65;
  wire signed  [WIDTH-1:0]  i1extp = i1;
  wire signed  [WIDTH-1:0]  i1ext = i1;
  wire signed  [WIDTH-1:0]  i63ext = i63;
  wire signed  [WIDTH-1:0]  i65ext = i65;
  integer cyc;

  
  initial    cyc = 0;
  
  always @(posedge clk)
      begin
        cyc <= 1+cyc;
        i1 <= cyc[0];
        i63 <= {63{cyc[0]}};
        i65 <= {65{cyc[0]}};
        case (cyc)

          1: begin
                if (i1extp != {WIDTH{1'b0}}) 
                  $stop;
                  
                if (i1ext != {WIDTH{1'b0}}) 
                  $stop;
                  
                if (i63ext != {WIDTH{1'b0}}) 
                  $stop;
                  
                if (i65ext != {WIDTH{1'b0}}) 
                  $stop;
                  
              end

          1+1: begin
                if (i1extp != {WIDTH{1'b1}}) 
                  $stop;
                  
                if (i1ext != {WIDTH{1'b1}}) 
                  $stop;
                  
                if (i63ext != {WIDTH{1'b1}}) 
                  $stop;
                  
                if (i65ext != {WIDTH{1'b1}}) 
                  $stop;
                  
              end

          default:  ;

        endcase

      end
endmodule

