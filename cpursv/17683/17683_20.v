
module sub;

  wire pub;
  wire [5:0]  assunu1 = 0;
  wire [3:0]  assunub2 = 0;
  wire [15:10] udrb2;

  assign udrb2[15] = 0;
  assign udrb2[12] = 0;
  assign udrb2[10] = 0;
  wire unu3;

  wire [3:0] mixed;

  assign mixed[2] = 0;
  assign mixed[0] = 0;
  localparam  THREE = 3;

  
  initial  
  begin
    if ((assunu1[0] != 0) && (udrb2 != 0) && 0) 
      begin

      end
      
    if (assunub2[THREE] && ((assunub2[1:0] != 0) && 0)) 
      begin

      end
      
    if (0 && (mixed[1:0] != 0)) 
      begin

      end
      
  end
endmodule

